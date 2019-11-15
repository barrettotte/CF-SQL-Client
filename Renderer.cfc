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
                    </div>
                </div>
            ');
        }
        return outHtml;
    }

    public string function renderDatasourceDropdown(){
        var outHtml = '';
        saveContent variable="outHtml"{
            writeOutput('Datasource:&nbsp;&nbsp;<select style="width:125px" name="datasources">');
            for(var dsName in structKeyList(application.datasources)){
                writeOutput('<option value=#dsName#>#dsName#</option>');
            }
            writeOutput('</select>');
        }
        return outHtml;
    }
}