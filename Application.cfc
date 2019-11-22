component output='false' hint='A basic SQL Client for MSSQL and DB2'{

    function onApplicationStart(){
        this.reload();
    }

    function onRequestStart(required string targetPage){
        // Manually refresh application - http://127.0.0.1:1234/index.cfm?reloadApp
        if(structKeyExists(url, 'reloadApp')){
            this.reload();
        }
    }

    public void function reload(){
        try{
            application.utils = createObject('component', 'components.utils').init();
            this.loadConfiguration('config.json');
        } catch(any e){
            application.utils.handleError(errMsg='Error starting application.', e=e, isFatal=true, toScreen=true);
        }
    }

    // Load relevant configuration data into application scope
    private void function loadConfiguration(required string configPath){
        application.config = structNew();
        local.config = application.utils.readJsonFile(arguments.configPath);
        if(!structKeyExists(local.config, 'secretKey')){
            throw "Credentials have not been encrypted. Please run 'task run tasks/setup'.";
        }
        this.loadDatasources(local.config);
        application.config.timeout = structKeyExists(local.config, 'timeout') ? local.config['timeout'] : 5;
        application.config.maxrows = structKeyExists(local.config, 'maxrows') ? local.config['maxrows'] : 100;
        application.config.secretKey = local.config.secretKey;
    }

    private void function loadDatasources(required struct config){
        if(!structKeyExists(arguments.config, 'datasources')){
            throw "Key 'datasources' was not found in configuration file.";
        }
        for(local.dsConfig in arguments.config.datasources){
            try{
                local.datasource = {
                    'class':            local.dsConfig['class'],
                    'connectionString': local.dsConfig['connectionString'],
                };
                local.datasource['username'] = local.dsConfig['username'];
                local.datasource['password'] = local.dsConfig['password'];
                application.datasources[local.dsConfig.name] = local.datasource;
            } catch(any e){
                application.utils.handleError(errMsg="Error reading datasource configuration.", e=e, isFatal=true);
            }
        }
    }

    public array function getDatasources(){
        return this.datasources();
    }

    public struct function getDatasource(required string dsName){
        if(structKeyExists(this.datasources, arguments.dsName)){
            return this.datasources[arguments.dsName];
        }
        application.utils.handleError(errMsg="Could not find datasource with key '#arguments.dsName#'.");
    }
}
