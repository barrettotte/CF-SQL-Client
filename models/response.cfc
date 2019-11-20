component output='false' accessors='true' hint='A simple response object'{
    
    property name = 'status'    type='Numeric';
    property name = 'data'      type='Struct';
    property name = 'error'     type='Array';

    public any function init(struct data){
        this.data = isDefined('arguments.data') ? arguments.data : structNew();
        this.error = arrayNew(1);
        this.status = 200;
        return this;
    }

    public void function addError(required any e, boolean changeStatus=true){
        arrayAppend(this.error, arguments.e);
        if(changeStatus){
            this.status = 500;
        }
    }

    public string function toJson() returnFormat="JSON"{
        return serializeJson(this);
    }

}
