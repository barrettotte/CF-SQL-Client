<div class="row">
  <div class="col">
    <form class="db-form" id="dbForm">
      <div class="form-group">
        Datasource:&nbsp;&nbsp;
        <select style="width:125px" name="ds">
          <cfscript>
            local.dftOpt = '<option value=""';
            if(!structKeyExists(request.data, "datasource")){
              local.dftOpt &= " selected";
            }
            writeOutput(local.dftOpt & ">--------------</option>");

            for(var dsName in structKeyList(application.datasources)){
              local.option = "<option value=#dsName#";
              if(structKeyExists(request.data, "datasource") && request.data.datasource == dsName){
                local.option &= " selected";
              }
              // TODO: inject 'selected' depending on request.data.datasource
              local.option &= ">#dsName#</option>";
              writeOutput(local.option);
            }
          </cfscript>
        </select>
      </div>
    </form>
  </div>
</div>
<hr>
<div class="row text-center">
  <div class="col">
    <h5><u>Datasource Info:</u></h5>
  </div>
</div>
<div class="row">
  <div class="col">
    <p>To Do</p>
    <div id="datasource-info">
    </div>
    <!-- TODO: 
      * Connection info - IP,Port
      * System usage - 
    -->
  </div>
</div>
<hr>
<div class="row">
  <div class="col text-center">
    <button class="btn btn-info" id="db-btn-update">Update</button>
  </div>
</div>

<!-- TODO: 
  * datasource database object browser ?
  * schemas, tables, views
  * functions, storedprocs, columns
-->
