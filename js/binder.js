// Handle binding buttons

window.onload = function(){
    this.bindOnClicks();
    this.bindOnChanges();
}

// Bind a button's on click event to function f
function bindOnClick(id, f){
    const btn = document.getElementById(id);
    btn.onclick = f.bind(btn);
}

function bindOnClicks(){
    this.bindOnClick('dbBtnUpdate', getDatasourceInfo);
    this.bindOnClick('sqlBtnRun', executeSql);
    this.bindOnClick('sqlBtnClear', clearSql);
}

function bindOnChanges(){
    const dsSelect = document.getElementById('datasourceSelect');
    dsSelect.onchange = getDatasourceInfo.bind(dsSelect);

    const sqlInFile = document.getElementById('sqlInFile');
    sqlInFile.onchange = loadFile.bind(sqlInFile);
}
