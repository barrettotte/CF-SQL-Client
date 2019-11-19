component output='false' hint='SQL execution and result set handling'{

    public any function init(){
        return this;
    }

    remote string function getDatasourceInfo(required string ds) returnFormat='JSON'{
        return serializeJson(application.datasources[arguments.ds]);
    }

    remote string function executeSql(required string ds) returnFormat='JSON'{
        // TODO: sanitize SQL string
        var req = deserializeJson(toString(getHTTPRequestData().content));
        return serializeJson(req);
    }

}