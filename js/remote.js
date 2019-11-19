// Handle remote calls to ColdFusion

function getDatasourceInfo(){
    try{
        const ds = getDatasource();
        if(ds !== ''){
            httpAsync('/handlers/sqlHandler.cfc?method=getDatasourceInfo&ds=' + ds, 'GET').then(resp => {
                var dsInfo = JSON.parse(resp);
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
                'sql': 'SELECT * FROM SOMEWHERE' // TODO: get data from file
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
