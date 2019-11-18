<!DOCTYPE html>
<html lang="en">
	<head>
    <meta charset="utf-8"> 
		<title>CF SQL Client</title>
    <meta name="description" content="A basic SQL Client for MSSQL and DB2">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="css/styles.css">
    <script src="js/handler.js"></script>
  </head>
	<body>
    <div class="container app-header">
      <div class="row text-center">
        <div class="col">
          <h3>CF SQL Client</h3>
        </div>
      </div>
    </div>
    <hr class="header-sep">
    <div class="container app">
      <div class="row">
        <div class="col-md-3 app-l-body">
          <cfinclude template="views/datasource.cfm"/>
        </div>
        <div class="col-md-9 app-r-body">
          <cfinclude template="views/sqlClient.cfm"/>
        </div>
      </div>
      <div class="row app-b-body">
        <cfinclude template="views/resultset.cfm"/>
      </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </body>
</html>
