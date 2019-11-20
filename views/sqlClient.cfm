<div class="row input-sql">
  <div class="col">
    <div class="row text-center">
      <div class="col">
        <p class="open-file" id="sqlOpenFile">untitled*</p>
      </div>
    </div>
    <textarea class="sql-textarea" id="sqlTextarea" autofocus name="sql" wrap="off"></textarea>
    <div class="row text-center sql-buttons">
      <div class="col">
        <label for="sqlInFile" class="btn btn-secondary" id="sqlBtnLoad">Load</label>
        <input type="file" id="sqlInFile" style="display:none" accept=".sql,.SQL"/>
      </div>
      <div class="col">
        <button class="btn btn-info" id="sqlBtnSave">Save</button>
      </div>
      <div class="col">
        <button class="btn btn-success" id="sqlBtnRun">Run</button>
      </div>
      <div class="col">
        <button class="btn btn-danger" id="sqlBtnClear">Clear</button>
      </div>
    </div>
  </div>
</div>
