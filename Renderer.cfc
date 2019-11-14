component{
    
    public any function init(){
        return this;
    }

    public void function renderDatasourceDropdown(){
        writeOutput('<select name="datasources">');
        for(var src in application.datasources){
            //var src = ds.name;
            //writeOutput('<option value=#src#>' & src & '</option>');
        }
        writeOutput('</select>');
    }
}