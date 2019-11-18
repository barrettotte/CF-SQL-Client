
window.onload = function(){
    this.bindOnClick('dbBtnUpdate', this.getDatasourceInfo);
    this.bindOnClick('sqlBtnRun', this.executeSql);
    
    const sqlInFile = document.getElementById('sqlInFile');
    sqlInFile.onchange = this.uploadFile.bind(sqlInFile);
}

function getDatasourceInfo(){
    try{
        const ds = getDatasource();
        if(ds !== ''){
            httpAsync('/dao/commonDao.cfc?method=getDatasourceInfo&ds=' + ds, 'GET').then(resp => {
                const dsInfo = document.getElementById('datasourceInfo');
                console.log(resp);
                
                var info = document.createElement('p');
                info.setAttribute('id', 'dsInfoTest')
                info.textContent = resp;
                
                // TODO: figure out how to do this ...
                dsInfo.appendChild(info);

                /* TODO: 
                    * Connection info - IP,Port
                    * System usage - 
                */
            });
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

function uploadFile(){
    try{
        var reader = new FileReader(); //TODO: read file in as string
        console.log("Uploading file...");
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
