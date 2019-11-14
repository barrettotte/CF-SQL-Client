component{

    public boolean function onApplicationStart(){
        try{
            application.applicationName = "CF-SQL-Client";
            application.utils = new Utils();
            this.loadConfiguration("config.json");
        } catch(any e){
            application.utils.handleError(errMsg="Error starting application.", e=e, isFatal=true, toScreen=true);
        }
        return true;
    }

    public boolean function onApplicationEnd(){
        // do nothing ... for now
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
