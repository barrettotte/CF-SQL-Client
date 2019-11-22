component output='false' hint='Build HTML string to pass back to frontend'{

    public any function init(){
        return this;
    }

    remote string function renderDatasourceInfo() returnFormat='JSON'{
        var resp = createObject('component', 'models.response').init();
        try{
            var outHtml = '';
            var req = deserializeJson(toString(getHTTPRequestData().content));
            savecontent variable='outHtml'{
                writeOutput('<ul>
                      <li><b>Name:&nbsp;</b>#req.name#</li>
                      <li><b>Type:&nbsp;</b>#req.type#</li>'
                );
                if(req.type == 'MSSQL'){
                    writeOutput('
                      <li><b>Host:&nbsp;</b>#req.host#</li>
                      <li><b>Memory:&nbsp;</b>#req.memory#</li>
                      <li><b>Threads:&nbsp;</b>#req.threads#</li>
                      <li><b>Objects:&nbsp;</b>#req.objects#</li>
                    ');   
                } else if(req.type == 'IBMi-DB2'){

                } else{
                    throw "Error unsupported db type '#req.type#'.";
                }
                writeOutput('</ul>');
            }
        } catch(any e){
            application.utils.dumpConsole('Error rendering datasource info.');
        }
        resp.data['HTML'] = outHtml;
        return resp.toJson();
    }

    remote string function renderResultsets() returnFormat='JSON'{
        var resp = createObject('component', 'models.response').init();
        var outHtml = '';
        try{
            var req = deserializeJson(toString(getHTTPRequestData().content));
            //application.utils.dumpConsole(req);
            savecontent variable='outHtml'{
                for(var result in req){
                    writeOutput('
                      <div class="container resultset-container my-4">
                        <div class="row horizontal-scrollable">
                          <div class="col">
                            <table class="table table-hover table-bordered table-dark">
                              <thead>
                                <tr>
                    ');
                    writeOutput('<th scope="col" class="text-center">##</th>');
                    for(var col in result['RESULTSETS']['COLUMNS']){
                        writeOutput('<th scope="col" class="text-center">#col#</th>');
                    }
                    writeOutput('
                                </tr>
                              </thead>
                    ');
                    var rows = result['RESULTSETS']['DATA'];
                    writeOutput('<tbody>');
                    for(var i = 1; i <= arrayLen(rows); i++){
                        var row = rows[i];
                        writeOutput('<tr><td>#i#</td>');
                        for(var j = 1; j <= arrayLen(row); j++){
                            writeOutput('<td>#row[j]#</td>');
                        }
                        writeOutput('</tr>');
                    }
                    writeOutput('
                              </tbody>
                            </table>
                          </div>
                        </div>
                      </div>
                    ');
                }
            }
        } catch(any e){
            application.utils.dumpConsole('Error rendering resultsets.');
        }
        resp.data['HTML'] = outHtml;
        return resp.toJson();
    }

}