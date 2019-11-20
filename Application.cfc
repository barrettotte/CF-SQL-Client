component output='false' hint='A basic SQL Client for MSSQL and DB2'{

    function onApplicationStart(){
        this.reload();
    }

    function onRequestStart(required string targetPage){
        request.serverTime = now();
        if(structKeyExists(url, 'reloadApp')){
            this.reload();
        } // Manually refresh application - http://127.0.0.1:1234/index.cfm?reloadApp

        // Process request event and route to appropriate controller
        request.event = arrayNew(1);
        if(!isNull(url.event) && len(trim(url.event))){
            request.event = listToArray(trim(url.event), '.');
        }
        request.data = structNew();
    }

    public void function reload(){
        try{            
            application.utils = createObject('component', 'utils').init();
            this.loadConfiguration('config.json');
        } catch(any e){
            application.utils.handleError(errMsg='Error starting application.', e=e, isFatal=true, toScreen=true);
        }
    }

    // Load relevant configuration data into application scope
    public void function loadConfiguration(required string configPath){
        var config = application.utils.readJsonFile(arguments.configPath);
        if(!structKeyExists(config, "secretKey")){
            throw "Credentials have not been encrypted. Please run 'task run tasks/setup'.";
        }
        for(local.ds in config.datasources){
            try{
                local.newDatasource = {
                    'class':            local.ds['class'],
                    'connectionString': local.ds['connectionString'],
                    'username':         local.ds['username'],
                    'password':         local.ds['password']
                };
                application.datasources[local.ds.name] = local.newDatasource;
                this.datasources[local.ds.name] = local.newDatasource;
            } catch(any e){
                application.utils.handleError(errMsg="Error reading datasource configuration.", e=e, isFatal=true);
            }
        }
        application.secretKey = config.secretKey;
    }
}
