<div class="row">
  <div class="col">
    Datasource:&nbsp;&nbsp;
    <select style="width:125px" name="ds" id="datasource-select">
      <cfscript>
        local.dftOpt = '<option value=""';
        if(!structKeyExists(request.data, 'datasource')){
          local.dftOpt &= ' selected';
        }
        writeOutput(local.dftOpt & '>--------------</option>');
        for(var dsName in structKeyList(application.datasources)){
          local.option = '<option value=#dsName#';
          local.option &= '>#dsName#</option>';
          writeOutput(local.option);
        }
      </cfscript>
    </select>
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
