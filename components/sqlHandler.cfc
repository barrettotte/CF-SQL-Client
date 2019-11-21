component output='true' hint='SQL execution and result set handling'{


    public any function init(){
        return this;
    }

    remote string function getDatasourceInfo(required string ds) returnFormat='JSON'{
        var resp = createObject('component', 'models.response').init();
        var dsInfo = application.datasources[arguments.ds];
        try{
            // TODO: separate by DB type
            
            resp.data = {
                'memory': 'N/A', 'host': 'N/A', 'threads': 'N/A', 'objects': 'N/A',
                'name': arguments.ds, 'type': this.classToDbType(dsInfo['class'])
            };
            var dsInfoQueries = getDatasourceInfoQueriesMSSQL();
            for(var q in dsInfoQueries){
                try{
                    resp.data[q.name] = this.executeStatement(q.sql, arguments.ds);
                } catch(any e){
                    break; // If one fails, cancel future requests.
                }
            }
        } catch(any e){
            application.utils.dumpConsole("Error gathering datasource information for '#arguments.ds#'.");
            application.utils.dumpConsole(e);
        }
        return resp.toJson();
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
                resp.data['results'] = resultsets;
            }
        } catch(any e){
            application.utils.dumpConsole("Error executing sql.");
            application.utils.dumpConsole(e);
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
        if(structKeyExists(datasource, 'username') && structKeyExists(datasource, 'password')){
            options['username'] = application.utils.appDecrypt(datasource.username);
            options['password'] = application.utils.appDecrypt(datasource.password);
        } else {
            application.utils.dumpConsole("Complete credentials for '#arguments.dsName#' were not found.");
            application.utils.dumpConsole(e);
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

    private array function getDatasourceInfoQueriesMSSQL(){
        return [
          { 'name': 'memory', 
            'sql':  'select total_physical_memory_kb as total_kb, available_physical_memory_kb as available_kb from sys.dm_os_sys_memory'
          },
          { 'name': 'threads', 
            'sql':  'select count(*) as total_threads from sys.dm_os_threads'
          },
          { 'name': 'host', 
            'sql':  'select host_platform as platform, host_distribution as distro from sys.dm_os_host_info'
          },
          { 'name': 'objects', 
            'sql':  'select count(*) as allocated_objects from sys.dm_os_memory_objects'
          }
        ];
    }

}