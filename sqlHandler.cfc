component output='false' hint='SQL execution and result set handling'{

    public any function init(){
        return this;
    }

    remote string function getDatasourceInfo(required string ds) returnFormat='JSON'{
        var dsInfo = application.datasources[arguments.ds];
        return serializeJson({
            'name': arguments.ds,
            'type': this.classToDbType(dsInfo['class'])
        });
    }

    remote string function executeSql(required string ds) returnFormat='JSON'{
        var resp = createObject('component', 'models.response').init();
        try{
            var req = deserializeJson(toString(getHTTPRequestData().content));
            if(structKeyExists(req, 'sql')){
                var resultsets = arrayNew(1);
                for(var stmt in this.splitSql(req.sql)){
                    arrayAppend(resultsets, this.executeStatement(stmt, arguments.ds));
                }
                resp.data['resultsets'] = resultsets;
            }
        } catch(any e){
            application.utils.handleError(errMsg='Error executing sql', e=e, isFatal=false, toScreen=true);
            resp.addError(e);
        }
        return resp.toJson();
    }

    private struct function executeStatement(required string sql, required string dsName){
        var result = {'sql': arguments.sql};
        var datasource = application.datasources[arguments.dsName];
        var options = {
            'datasource': arguments.dsName,
            'timeout':    application.config.timeout, 
            'maxRows':    application.config.maxrows
        };
        dump(var=datasource, output='console');
        //throw "STOP HERE";

        // If username and password not found, its assumed integratedSecurity is being used
        if(structKeyExists(datasource, 'username') && structKeyExists(datasource, 'password')){
            options['username'] = application.utils.appDecrypt(datasource.username);
            options['password'] = application.utils.appDecrypt(datasource.password);
        }
        result.resultsets = queryExecute(sql=arguments.sql, options=options, params=structNew());
        return result;
    }

    private array function splitSql(required string sql){
        var cleaned = replaceNoCase(trim(arguments.sql), chr(10), '', 'All');
        cleaned = replaceNoCase(cleaned, chr(13), '', 'All');
        return cleaned.split(';');
    }

    private string function classToDbType(required string className){
        switch(arguments.className){
            case 'com.microsoft.jdbc.sqlserver.SQLServerDriver':
                return 'MSSQL';
            // TODO: db2 driver
        }
        throw "Unhandled driver class type '" & arguments.className & "'";
    }

}