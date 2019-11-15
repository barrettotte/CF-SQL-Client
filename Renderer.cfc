component{
    
    public any function init(){
        return this;
    }

    public string function renderAppLeft(){
        var outHtml = '';
        saveContent variable="outHtml"{
            writeOutput('
              <div class="row">
                <div class="col">
                  #this.renderDatasourceDropdown()#
                  <hr>
                  #this.renderDatasourceInfo(structNew())#
                  <hr>
                </div>
              </div>
            ');
        }
        return outHtml;
    }

    public string function renderAppRight(){
        var outHtml = '';
        saveContent variable="outHtml"{
            writeOutput('
              <div class="row input-sql">
                <div class="col">
                  #this.renderSqlForm()#
                </div>
              </div>
            ');
        }
        return outHtml;
    }

    public string function renderDatasourceDropdown(){
        var outHtml = '';
        saveContent variable="outHtml"{
            writeOutput('
              Datasource:&nbsp;&nbsp;
              <select style="width:125px" name="datasources">
                #this.renderDatasourceOptions()#
              </select>
            ');
        }
        return outHtml;
    }

    public string function renderDatasourceOptions(){
        var outHtml = '';
        saveContent variable="outHtml"{
            for(var dsName in structKeyList(application.datasources)){
                writeOutput('<option value=#dsName#>#dsName#</option>');
            }
        }
        return outHtml;
    }

    public string function renderDatasourceInfo(required struct ds){
        var outHtml = '';
        saveContent variable="outHtml"{
            // TODO:
            writeOutput('
              <div class="row text-center">
                <div class="col">
                  <h5>
                    <u>Datasource Info:</u>
                  </h5>
                </div>
              </div>
              <div class="row">
                <div class="col">
                  <p>To Do</p>
                </div>
              </div>
            ');
        }
        return outHtml;
    }

    public string function renderSqlForm(){
        var outHtml = '';
        saveContent variable="outHtml"{
            writeOutput('
              <form class="sql-form" id="sqlForm">
                <div class="form-group">
                  #this.renderSqlFormTextarea()#
                  #this.renderSqlFormButtons()#
                </div>
              </form>
            ');
        }
        return outHtml;
    }

    public string function renderSqlFormTextarea(){
        var outHtml = '';
        saveContent variable="outHtml"{
            writeOutput('
              <textarea
                class="sql-textarea" id="sql-textarea"
                autofocus name="sqlTextarea" wrap="off">
              </textarea>
            ');
        }
        return outHtml;
    }

    public string function renderSqlFormButtons(){
        var outHtml = '';
        saveContent variable="outHtml"{
            writeOutput('
              <div class="row text-center sql-buttons">
                <div class="col">
                  <button type="button" class="btn btn-secondary" onclick="this.blur();">Load</button>
                </div>
                <div class="col">
                  <button type="button" class="btn btn-info" onclick="this.blur();">Save</button>
                </div>
                <div class="col">
                  <button type="button" class="btn btn-success" onclick="this.blur();">Run</button>
                </div>
                <div class="col">
                  <button type="button" class="btn btn-danger" onclick="this.blur();">Clear</button>
                </div>
              </div>
            ');
        }
        return outHtml;
    }

}