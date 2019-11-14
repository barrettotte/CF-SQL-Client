component{

    void function assertStructKeyExists(required struct st, required string key){
        if(!structKeyExists(arguments.st, arguments.key)){
            throw "Key '#arguments.key#' not found in struct.";
        }
    }

    string function appEncrypt(required string decrypted){
        this.assertStructKeyExists(application, "secretKey");
        return encrypt(arguments.decrypted, application.secretKey);
    }

    string function appDecrypt(required string encrypted){
        this.assertStructKeyExists(application, "secretKey");
        return decrypt(arguments.encrypted, application.secretKey);
    }

    // Read json file into struct
    struct function readJsonFile(required string path){
        var fullPath = expandPath(arguments.path);
        try{
            if(fileExists(arguments.path)){
                return deserializeJson(fileRead(path));
            }
            throw "Could not find file at '#fullPath#'.";
        } catch(any e){
            throw "Error occurred reading file at '#fullPath#'.";
        }
        return null;
    }

    // Simple error handler to output to screen and console; ends application if isFatal
    void function handleError(required string errMsg, any e=null, boolean isFatal=false, boolean toScreen=false){
        this.dumpConsole(arguments.errMsg);
        if(arguments.toScreen){
            writeOutput("<p style='color:red'>" & arguments.errMsg & "</p>");
        }
        if(!isNull(arguments.e)){
            this.dumpConsole(arguments.e);
            if(arguments.toScreen){
                writeOutput(arguments.e);
            }
        }
        if(arguments.isFatal){
            applicationStop();
        }
    }

    // Dump object to console
    void function dumpConsole(required any x){
        dump(var=arguments.x, output="console");
    }

    // Prettify a json string
    string function prettifyJson(required string jsonStr){
        var pretty = '';
        var depth = 0;
        try{
            for(var i = 0; i < len(arguments.jsonStr); i++){
                var char = arguments.jsonStr.substring(i, i+1);
                if(char == '}' || char == ']'){
                    pretty &= chr(10) & repeatString("  ", --depth);
                }
                pretty &= char;
                if(char == '{' || char == '[' || char == ','){
                    pretty &= chr(10);
                    if(char == '{' || char == '['){
                        depth++;
                    }
                    pretty &= repeatString("  ", depth)
                }
            }
        } catch(any e){
            throw "Error prettifying json string.";
        }
        return pretty;
    }

}
