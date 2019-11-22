component output='true' hint='SQL execution and result set handling'{


    public any function init(){
        return this;
    }

    remote string function getDatasourceInfo(required string ds) returnFormat='JSON'{
        var resp = createObject('component', 'models.response').init();
        try{
            var dbType = this.classToDbType(application.datasources[arguments.ds]['class']);
            resp.data = getDsInfoStruct(dbType);
            resp.data['name'] = arguments.ds;

            for(var q in this.getDsInfoQueries(dbType)){
                dump(var=q, output='console');
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
            case 'com.ibm.as400.access.AS400JDBCDriver':
                return 'IBMi-DB2';
        }
        throw "Unhandled driver class type '" & arguments.className & "'";
    }

    private struct function getDsInfoStruct(required string dbType){
        var st = structNew();
        if(arguments.dbType == 'MSSQL'){
            st = {'memory':'N/A', 'host':'N/A', 'threads':'N/A', 'objects':'N/A'};
        } else if(arguments.dbType == 'IBMi-DB2'){
            st = {'sys':'N/A', 'libraries':'N/A'};
        }
        else{
            throw "Error unsupported db type '#arguments.dbType#'.";
        }
        st['type'] = arguments.dbType;
        return st;
    }

    private array function getDsInfoQueries(required string dbType){
        var queries = arrayNew(1);
        if(arguments.dbType == 'MSSQL'){
            queries = [
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
        } else if(arguments.dbType == 'IBMi-DB2'){
            queries = [
                { 'name': 'sys',
                  'sql':  'select host_name as host, active_jobs_in_system as jobs, active_threads_in_system as threads, 
                             average_cpu_utilization as cpu_usage from qsys2.system_status_info'
                },
                { 'name': 'libraries',
                  'sql':  "select count(*) as libraries from table (qsys2.object_statistics('*ALL', 'LIB'))"
                }
            ];
        } else {
            throw "Error unsupported db type '#arguments.dbType#'.";
        }
        return queries;
    }

}