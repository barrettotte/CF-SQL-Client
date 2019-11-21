component{
    // This is only run once on new setup. Generate AES secret key and encrypt datasource credentials. 
    // Overwrites config.json with encrypted credentials.

    function run(){
        try{
            var configPath = "../config.json";
            var config = this.readJsonFile(configPath);
            if(!structKeyExists(config, "secretKey")){
                var secretKey = randRange(0, 2048, 'SHA1PRNG'); // used in XOR encryption
                var newConfig = {'secretKey': secretKey, 'datasources': arrayNew(1)};
                for(var ds in config.datasources){
                    ds['username'] = this.xorEncrypt(ds['username'], secretKey);
                    ds['password'] = this.xorEncrypt(ds['password'], secretKey);
                    arrayAppend(newConfig['datasources'], ds);
                }
                fileWrite(configPath, this.prettifyJson(serializeJson(newConfig)));
            } else {
                dump(var="Datasource credentials seem to already be encrypted.", output="console");
            }
        } catch(any e){
            throw "Error encrypting datasource credentials.";
        }
    }

    private string function xorEncrypt(required string toEncrypt, required string secretKey){
        local.encrypted = '';
        for (var i = 1; i <= len(arguments.toEncrypt); i++){
            local.encrypted &= chr(bitXor(asc(mid(arguments.toEncrypt, i, 1)), arguments.secretKey) % 256);
        }
        return local.encrypted;
    }

    private struct function readJsonFile(required string path){
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

    private string function prettifyJson(required string jsonStr){
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