<!DOCTYPE html>
<html lang="en">
	<head>
    <meta charset="utf-8"> 
		<title>CF SQL Client</title>
    <meta name="description" content="A simple SQL Client for DB2 and MSSQL">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  </head>
	<body>
		<h2>CF SQL Client</h2>
		<hr>
		<cfscript>
      local.renderer = new Renderer();
      local.sqlRunner = new SqlRunner();
		</cfscript>

		<div class="container">
      <cfscript>
        dump(application.datasources);
        dump(structKeyList(application.datasources));
        
        local.renderer.renderDatasourceDropdown();
        writeOutput(local.sqlRunner.helloWorld());
      </cfscript>
		</div>

	</body>
</html>