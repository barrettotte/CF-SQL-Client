
window.onload = function(){
    this.bindButton("db-btn-update", this.dbBtnUpdateClick);
    this.bindButton("sql-btn-run", this.sqlBtnRunClick);
}

function bindButton(id, f){
    const btn = document.getElementById(id);
    btn.onclick = f.bind(btn);
}

function dbBtnUpdateClick(){
    try{
        httpGetAsync("/SqlRunner.cfc?method=helloWorld&test=wasd").then(resp => {
            const dsInfo = document.getElementById("datasource-info");
            
            console.log(resp);
            
            var info = document.createElement("p");
            info.setAttribute("id", "ds-info-test")
            info.textContent = "Hello World";
            
            dsInfo.appendChild(info);
        });
    } catch(error){
        console.error(error);
    }
}

function sqlBtnRunClick(){
    console.log("Run clicked!");
}

async function httpGetAsync(url){
    const options = { 
        method: 'GET', 
        headers: {'Content-Type': 'application/json'}
    };
    const response = await fetch(url, options);
    const json = await response.json()
    return json;
}
