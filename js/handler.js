// Handle remote calls to ColdFusion and some DOM manipulation

function getDatasourceInfo(){
    try{
        const ds = getDatasource();
        if(ds !== ''){
            remoteCfAsync('/components/sqlHandler.cfc?method=getDatasourceInfo&ds=' + ds, 'GET').then(resp => {
                const respJson = JSON.parse(resp);
                if(respJson['STATUS'] === 200 && respJson['ERROR'].length === 0){
                    remoteCfAsync('/components/renderer.cfc?method=renderDatasourceInfo', 'POST', respJson['DATA']).then(render => {
                        document.getElementById('datasourceInfo').innerHTML = JSON.parse(render)['DATA']['HTML'];
                    });
                }
            });
        } else{
            document.getElementById('datasourceInfo').innerHTML = '';
        }
    } catch(error){
        console.error(error);
    }
    this.blur();
}

function executeSql(){
    try{
        const ds = getDatasource();
        if(ds !== ""){
            const sql = getSqlTextarea().value;
            if(sql.length > 0){
                const data = { 'sql': getSqlTextarea().value }; 
                remoteCfAsync('/components/sqlHandler.cfc?method=executeSql&ds=' + ds, 'POST', data).then(resp => {
                    const respJson = JSON.parse(resp);
                    if(respJson['STATUS'] === 200 && respJson['ERROR'].length === 0){
                        remoteCfAsync('/components/renderer.cfc?method=renderResultsets', 'POST', respJson['DATA']['results']).then(render => {
                            document.getElementById('resultsetContent').innerHTML = JSON.parse(render)['DATA']['HTML'];
                        });
                    } else{
                        //TODO: error render
                        alert('SQL execution produced an error! View Console.');
                        console.error(respJson['ERROR']);
                    }
                });
            } else{
                alert('Cannot execute blank SQL string!');
            }
        } else{
            alert('Select a datasource!');
        }
    } catch(error){
        console.error(error);
    }
    this.blur();
}

function loadFile(){
    try{
        const files = document.getElementById('sqlInFile').files;
        if(files.length > 0){
            const file = files[0];
            fileToString(file, (s) => {
                getSqlOpenFilename().innerHTML = file.name;
                getSqlTextarea().value = s;
            });
        }
    } catch(error){
        console.error(error);
    }
    this.blur();
}

function clearSql(){
    try{
        getSqlTextarea().value = '';
        getSqlOpenFilename().innerHTML = 'untitled*';
    } catch(error){
        console.error(error);
    }
    this.blur();
}
