component output="false" hint="A basic SQL Client for MSSQL and DB2"{

    public function onApplicationStart(){
        application.initTime = now();
        application.applicationName = "CF-SQL-Client";
        try{            
            application.utils = new Utils();
            this.loadConfiguration("config.json");
        } catch(any e){
            application.utils.handleError(errMsg="Error starting application.", e=e, isFatal=true, toScreen=true);
        }
        return true;
    }

    public boolean function onApplicationEnd(){
        return true;
    }

    public boolean function onSessionStart(){
        return true;
    }

    public boolean function onRequestStart(required string targetPage){
        request.serverTime = now();

        if(structKeyExists(url, "reloadApp")){
            systemCacheClear(cacheName="all");
            this.onApplicationStart();
            this.onSessionStart();
        } // Manually refresh application - http://127.0.0.1:1234/index.cfm?reloadApp

        // Process request event and route to appropriate controller
        request.event = arrayNew(1);
        if(!isNull(url.event) && len(trim(url.event))){
            request.event = listToArray(trim(url.event), ".");
        }
        request.data = structNew();
        return true;
    }

    public boolean function onRequest(required string targetPage){
        include "./index.cfm";
        return true;
    }

    public boolean function onRequestEnd(required string targetPage){
        return true;
    }

    public boolean function onError(any e, string eventName){
        if(structKeyExists(application, "utils")){
            application.utils.handleError(
                errMsg="Application encountered error with event '" & arguments.eventName & "'", e=arguments.e
            );
        } else{
            dump(var=arguments.e, output="console");
        }
        abort;
    }

    // Load relevant configuration data into application scope
    private void function loadConfiguration(required string configPath){
        var config = application.utils.readJsonFile(arguments.configPath);
        if(!structKeyExists(config, "secretKey")){
            throw "Credentials have not been encrypted. Please run 'task run tasks/setup'.";
        }
        for(local.ds in config.datasources){
            try{
                application.datasources[local.ds.name] = local.ds;
            } catch(any e){
                this.handleError(errMsg="Error reading datasource configuration.", e=e, isFatal=true);
            }
        }
        application.secretKey = config.secretKey;
    }
}
