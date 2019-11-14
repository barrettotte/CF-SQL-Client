component{

    boolean function onApplicationStart(){
        try{
            application.applicationName = "CF-SQL-Client";
            local.configPath = "config.json";
            application.utils = new Utils();
            local.config = application.utils.readJsonFile(local.configPath);
            if(!structKeyExists(local.config, "secretKey")){
                application.secretKey = generateSecretKey("AES", 256);
                local.config = this.encryptCredentials(local.config, local.configPath);
            }
            this.loadConfiguration(local.config);
        } catch(any e){
            application.utils.handleError(errMsg="Error starting application.", e=e, isFatal=true, toScreen=true);
        }
        return true;
    }

    boolean function onApplicationEnd(){
        // do nothing ... for now
    }
    
    // This is only run once on new setup. Generate AES secret key and encrypt datasource credentials. 
    // Overwrites config.json with encrypted credentials.
    private struct function encryptCredentials(required struct config, required string configPath){
        try{
            application.utils.assertStructKeyExists(application, 'secretKey');
            application.utils.assertStructKeyExists(arguments.config, 'datasources');
            var newConfig = {'secretKey': application.secretKey, 'datasources': arrayNew(1)};
            for(var ds in arguments.config.datasources){
                ds['username'] = application.utils.appEncrypt(ds['username']);
                ds['password'] = application.utils.appEncrypt(ds['password']);
                arrayAppend(newConfig['datasources'], ds);
            }
            fileWrite(arguments.configPath, application.utils.prettifyJson(serializeJson(newConfig)));
        } catch(any e){
            application.utils.handleError(errMsg="Error encrypting datasource credentials.", e=e, isFatal=true);
        }
        return newConfig;
    }

    // Load relevant configuration data into application scope
    private void function loadConfiguration(required struct config){
        if(!structKeyExists(application, 'secretKey')){
            application.secretKey = arguments.config.secretKey;
        }
        for(local.ds in arguments.config.datasources){
            try{
                application.datasources[local.ds.name] = local.ds;
            } catch(any e){
                this.handleError(errMsg="Error reading datasource configuration.", e=e, isFatal=true);
            }
        }
    }
}
