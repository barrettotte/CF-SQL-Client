// Handle remote calls to ColdFusion

function getDatasourceInfo(){
    try{
        const ds = getDatasource();
        if(ds !== ''){
            httpAsync('/handlers/sqlHandler.cfc?method=getDatasourceInfo&ds=' + ds, 'GET').then(resp => {
                var dsInfo = JSON.parse(resp);
                console.log(dsInfo);
                document.getElementById('datasourceInfo').innerHTML = `
                  <ul>
                    <li><b>Name:</b> ${dsInfo['name']}</li>
                    <li><b>Type:</b> ${dsInfo['type']}</li>
                  </ul>
                `;
            });
        } else {
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
            const data = {
                'sql': getSqlTextarea().value
            }; 
            httpAsync('/handlers/sqlHandler.cfc?method=executeSql&ds=' + ds, 'POST', data).then(resp => {
                console.log(resp);
            });
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

