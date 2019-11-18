
window.onload = function(){
    this.bindButton('db-btn-update', this.dbBtnUpdateClick);
    this.bindButton('sql-btn-run', this.sqlBtnRunClick);
}

function dbBtnUpdateClick(){
    try{
        const ds = getDatasource();
        if(ds !== ''){
            httpAsync('/sqlHandler.cfc?method=getDatasourceInfo&ds=' + ds, 'GET').then(resp => {
                const dsInfo = document.getElementById('datasource-info');
                console.log(resp);
                
                var info = document.createElement('p');
                info.setAttribute('id', 'ds-info-test')
                info.textContent = resp;
                
                // TODO: figure out how to do this ...
                dsInfo.appendChild(info);
            });
        }
    } catch(error){
        console.error(error);
    }
    this.blur();
}

function sqlBtnRunClick(){
    try{
        const ds = getDatasource();
        if(ds !== ""){
            const data = {
                'sql': 'SELECT * FROM SOMEWHERE'
            };
            httpAsync('/sqlHandler.cfc?method=executeSql&ds=' + ds, 'POST', data).then(resp => {
                console.log(resp);
            });
        }
    } catch(error){
        console.error(error);
    }
    this.blur();
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

function bindButton(id, f){
    const btn = document.getElementById(id);
    btn.onclick = f.bind(btn);
}

function getSelectedOption(id){
    const sel = document.getElementById(id);
    return sel.options[sel.selectedIndex].value;
}

function getDatasource(){
    return getSelectedOption('datasource-select');
}
