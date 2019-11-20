<div class="row">
  <div class="col">
    Datasource:&nbsp;&nbsp;
    <select style="width:125px" name="ds" id="datasourceSelect">
      <cfscript>
        writeOutput('<option value="">--------------</option>');
        for(dsName in structKeyList(application.datasources)){
          option = '<option value=#dsName#';
          option &= '>#dsName#</option>';
          writeOutput(option);
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
      <!-- Populated by JS later ... -->
    </div>
  </div>
</div>
<hr>
<div class="row">
  <div class="col text-center">
    <button class="btn btn-info" id="dbBtnUpdate">Update</button>
  </div>
</div>
