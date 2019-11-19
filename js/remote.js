// Handle remote calls to ColdFusion

function getDatasourceInfo(){
    try{
        const ds = getDatasource();
        if(ds !== ''){
            httpAsync('/dao/commonDao.cfc?method=getDatasourceInfo&ds=' + ds, 'GET').then(resp => {
                var s = '';
                s += `<p>${resp}</p>`;
                document.getElementById('datasourceInfo').innerHTML = s;
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
                'sql': 'SELECT * FROM SOMEWHERE' // TODO: get data and sanitize from textarea
            }; 
            httpAsync('/dao/commonDao.cfc?method=executeSql&ds=' + ds, 'POST', data).then(resp => {
                console.log(resp);
            });
        }
    } catch(error){
        console.error(error);
    }
    this.blur();
}

function fileWasUploaded(){
    try{
        console.log("Uploading file...");
        // TODO: lock sql textarea
    } catch(error){
        console.error(error);
    }
    this.blur();
}

function clearSql(){
    try{
        document.getElementById("sqlTextarea").value = '';
        document.getElementById("sqlOpenFile").innerHTML = 'untitled*';
        // TODO: clear open file display
    } catch(error){
        console.error(error);
    }
    this.blur();
}

function loadSql(){
    try{
        document.getElementById("sqlOpenFile").innerHTML = 'something.sql';  // TODO: file name
        // TODO: unlock sql textarea
    } catch(error){
        console.error(error);
    }
}
