component{

    boolean function onApplicationStart(){
        local.configPath = "config.json";
        local.config = this.readConfigJson(local.configPath);
        if(!structKeyExists(local.config, "secretKey")){
            this.populateSecretKey(local.config, local.configPath);
        }
        this.initDatasources(local.config.datasources);
        return true;
    }

    boolean function onApplicationEnd(){}

    private void function populateSecretKey(required struct config, required string configPath){
        try{
            var newConfig = structCopy(arguments.config);
            newConfig['secretKey'] = generateSecretKey("AES", 128);
            fileWrite(arguments.configPath, serializeJson(newConfig));
        } catch(any e){
            this.handleError(errMsg="Error populating secret key.", exc=e, isFatal=true);
        }
    }

    private void function initDatasources(required array dsConfig){
        for(var ds in arguments.dsConfig){
            try{
                if(!(structKeyExists(this, "defaultDatasource") && structKeyExists(this, "datasource"))){
                    this.defaultDatasource = ds.name;
                    this.datasource = ds.name;
                }
                this.datasources[ds.name] = ds;
            } catch(any e){
                this.handleError(errMsg="Error reading datasource configuration.", exc=e, isFatal=true);
            }
        }
    }

    private struct function readConfigJson(required string configPath){
        var fullPath = expandPath(arguments.configPath);
        try{
            if(fileExists(arguments.configPath)){
                return deserializeJson(fileRead(configPath));
            }
            this.handleError(errMsg="Could not find config file at '#fullPath#'.", isFatal=true);
        } catch(any e){
            this.handleError(errMsg="Error occurred reading config file at '#fullPath#'.", exc=e, isFatal=true);
            dump(var=e, output="console");
        }
        return null;
    }

    private void function handleError(required string errMsg, any exc=null, boolean isFatal=false){
        writeOutput("<p style='color:red'>" & arguments.errMsg & "</p>");
        dump(var=arguments.errMsg, output="console");

        if(!isNull(arguments.exc)){
            dump(var=arguments.exc, output="console");
            writeOutput(arguments.exc);
        }
        if(arguments.isFatal){
            applicationStop();
        }
    }
}
