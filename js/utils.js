// Misc utilities

function fileToString(file, callback){
    const reader = new FileReader();
    try{
        reader.readAsText(file);
        reader.onload = () => {
            callback(reader.result);
        }
    } catch(error){
        console.error(error);
    }
}

async function httpAsync(url, method='GET', body={}){
    const options = { 
        method: method,
        headers: {'Content-Type': 'application/json'},
    };
    var json = '';
    try{
        if(method === 'POST' || method === 'PUT'){
            options['body'] = JSON.stringify(body);
        }
        const response = await fetch(url, options);
        json = await response.json();
    } catch(error){
        console.error(error);
    }
    return json;
}

// Get selected option of a 'select' element
function getSelectedOption(id){
    const sel = document.getElementById(id);
    return sel.options[sel.selectedIndex].value;
}

function getDatasource(){
    return getSelectedOption('datasourceSelect');
}

function getSqlTextarea(){
    return document.getElementById("sqlTextarea");
}

function getSqlOpenFilename(){
    return document.getElementById("sqlOpenFile");
}
