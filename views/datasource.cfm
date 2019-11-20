<div class="row">
  <div class="col">
    Datasource:&nbsp;&nbsp;
    <select style="width:125px" name="ds" id="datasourceSelect">
      <cfscript>
        local.dftOpt = '<option value=""';
        if(!structKeyExists(request.data, 'datasource')){
          local.dftOpt &= ' selected';
        }
        writeOutput(local.dftOpt & '>--------------</option>');
        for(local.dsName in structKeyList(application.datasources)){
          local.option = '<option value=#local.dsName#';
          local.option &= '>#local.dsName#</option>';
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
    <div id="datasourceInfo">
      <!-- Populated with Async JS later ... -->
    </div>
  </div>
</div>
<hr>
<div class="row">
  <div class="col text-center">
    <button class="btn btn-info" id="dbBtnUpdate">Update</button>
  </div>
</div>

<!-- TODO: 
  * datasource database object browser ?
  * schemas, tables, views
  * functions, storedprocs, columns
-->
