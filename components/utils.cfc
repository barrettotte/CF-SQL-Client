component hint='Utilities accessible in application scope'{

    public any function init(){
        return this;
    }

    public void function assertStructKeyExists(required struct st, required string key){
        if(!structKeyExists(arguments.st, arguments.key)){
            throw "Key '#arguments.key#' not found in struct.";
        }
    }

    public string function appEncrypt(required string toEncrypt, string algorithm = 'XOR'){
        try{
            this.assertStructKeyExists(application.config, 'secretKey');
            if(arguments.algorithm == 'XOR'){
                return this.xorEncrypt(arguments.toEncrypt, application.config.secretKey);
            } 
            else if(arguments.algorithm == 'AES'){
                return encrypt(string=arguments.toEncrypt, key=application.config.secretKey, 
                    algorithm='AES', encoding='Base64', iterations=500);
            }
            else {
                throw "Unsupported encryption algorithm '#arguments.algorithm#'.";
            }
        } catch(any e){
            this.handleError(errMsg="Error occurred encrypting string.", e=e, isFatal=true);
        }
    }

    public string function appDecrypt(required string toDecrypt, string algorithm = 'XOR'){
        try{
            this.assertStructKeyExists(application.config, 'secretKey');
            if(arguments.algorithm == 'XOR'){
                return this.xorEncrypt(arguments.toDecrypt, application.config.secretKey);
            }
            else if(arguments.algorithm == 'AES'){
                return decrypt(encrypted_string=arguments.toDecrypt, key=application.config.secretKey,
                    algorithm='AES', encoding='Base64', iterations=500);
            } else {
                throw "Unsupported encryption algorithm '#arguments.algorithm#'.";
            }
        } catch(any e){
            this.handleError(errMsg="Error occurred decrypting string.", e=e, isFatal=true);
        }
    }

    // Simple XOR encryption. Handles encrypting/decrypting.
    private string function xorEncrypt(required string toEncrypt, required string secretKey){
        local.encrypted = '';
        for (var i = 1; i <= len(arguments.toEncrypt); i++){
            local.encrypted &= chr(bitXor(asc(mid(arguments.toEncrypt, i, 1)), arguments.secretKey) % 256);
        }
        return local.encrypted;
    }

    // Read json file into struct
    public struct function readJsonFile(required string path){
        local.fullPath = expandPath(arguments.path);
        try{
            if(fileExists(arguments.path)){
                return deserializeJson(fileRead(arguments.path));
            }
            throw "Could not find file at '#local.fullPath#'.";
        } catch(any e){
            throw "Error occurred reading file at '#local.fullPath#'.";
        }
        return null;
    }

    // Simple error handler to output to screen and console; ends application if isFatal
    public void function handleError(required string errMsg, any e=null, boolean isFatal=false, boolean toScreen=false){
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
    public void function dumpConsole(required any x){
        dump(var=arguments.x, output='console');
    }

    // Dump object to screen with newline after
    public void function dumpScreenN(required any x){
        dump(var=arguments.x);
        writeOutput('<br>');
    }

    // Prettify a json string
    public string function prettifyJson(required string jsonStr){
        var pretty = '';
        var depth = 0;
        try{
            for(var i = 0; i < len(arguments.jsonStr); i++){
                var char = arguments.jsonStr.substring(i, i+1);
                if(char == '}' || char == ']'){
                    pretty &= chr(10) & repeatString('  ', --depth);
                }
                pretty &= char;
                if(char == '{' || char == '[' || char == ','){
                    pretty &= chr(10);
                    if(char == '{' || char == '['){
                        depth++;
                    }
                    pretty &= repeatString('  ', depth)
                }
            }
        } catch(any e){
            throw 'Error prettifying json string.';
        }
        return pretty;
    }
}
