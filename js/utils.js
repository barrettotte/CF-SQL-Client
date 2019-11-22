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

async function remoteCfAsync(url, method='GET', body={}){
    try{
        const options = {method: method, headers: {'Content-Type': 'application/json'}};
        if(method === 'POST' || method === 'PUT'){
            options['body'] = JSON.stringify(body);
        }
        const response = await fetch(url, options);
        return await response.json();
    } catch(error){
        console.error(error);
    }
    throw 'Async request to remote CF method did not complete.';
}

// Check if string is able to be parsed to JSON
function isJson(s) {
    try {
        JSON.parse(s);
    } catch (e) {
        return false;
    }
    return true;
}

// Get selected option of a 'select' element
function getSelectedOption(id){
    const sel = document.getElementById(id);
    return sel.options[sel.selectedIndex].value;
}

var getDatasource = () => getSelectedOption('datasourceSelect');

var getSqlTextarea = () => document.getElementById("sqlTextarea");

var getSqlOpenFilename = () => document.getElementById("sqlOpenFile");

var getResultsetContent = () => document.getElementById('resultsetContent');
