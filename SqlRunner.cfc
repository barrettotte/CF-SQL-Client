component output="false" hint="SQL execution and result set handling"{

    public any function init(){
        return this;
    }

    remote string function helloWorld(required string test) returnFormat="JSON"{
        return serializeJSON({"test": arguments.test});
    }

}