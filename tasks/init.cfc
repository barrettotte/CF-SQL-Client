component{

    function initConfiguration(){
        this.initSecretKey();

    }

    private void function initSecretKey(){
        try{
            var newConfig = structCopy(arguments.config);
            newConfig['secretKey'] = generateSecretKey("AES", 128);
            fileWrite(arguments.configPath, serializeJson(newConfig));
        } catch(any e){
            this.handleError(errMsg="Error populating secret key.", exc=e, isFatal=true);
        }
    }
    
}