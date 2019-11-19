
window.onload = function(){
    this.bindOnClick('dbBtnUpdate', this.getDatasourceInfo);
    this.bindOnClick('sqlBtnRun', this.executeSql);
    this.bindOnClick('sqlBtnClear', this.clearSql);
    this.bindOnClick('sqlBtnLoad', this.loadSql);
    
    const dsSelect = document.getElementById('datasourceSelect');
    dsSelect.onchange = this.getDatasourceInfo.bind(dsSelect);

    const sqlInFile = document.getElementById('sqlInFile');
    sqlInFile.onchange = this.uploadFile.bind(sqlInFile);
}

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

function loadSql(){
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

function uploadFile(){
    try{
        // async ?
        //var reader = new FileReader(); //TODO: read file in as string, *.sql files only
        document.getElementById("sqlOpenFile").innerHTML = 'something.sql';  // TODO: file name
        // TODO: unlock sql textarea
    } catch(error){
        console.error(error);
    }
}

async function httpAsync(url, method='GET', body={}){
    const options = { 
        method: method,
        headers: {'Content-Type': 'application/json'},
    };
    if(method === 'POST' || method === 'PUT'){
        options['body'] = JSON.stringify(body);
    }
    const response = await fetch(url, options);
    const json = await response.json();
    return json;
}

function bindOnClick(id, f){
    const btn = document.getElementById(id);
    btn.onclick = f.bind(btn);
}

function getSelectedOption(id){
    const sel = document.getElementById(id);
    return sel.options[sel.selectedIndex].value;
}

function getDatasource(){
    return getSelectedOption('datasourceSelect');
}
