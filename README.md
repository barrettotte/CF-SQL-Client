# CF-SQL-Client

A simple SQL client for DB2 and MSSQL written with Lucee.
This was made to just screw around with Lucee, JS, and some SQL.
Pay no attention to the ugly JavaScript I used to tie my frontend to backend.


## Features
* Selectable datasource
* Detect datasource type - DB2,MSSQL,Unknown
* Enter SQL string in textbox with Syntax highlighting
* Execute SQL string
* Basic error handling
* Pretty print resultsets with Bootstrap
* Basic database browser - schemas, tables, procs, system info, etc.


## Setup
Enter datasources into **config.json**
```javascript
// config.json
{
  "datasources": [
    {
      "name":"MY_MSSQL",
      "type":"mssql",
      "class":"com.microsoft.jdbc.sqlserver.SQLServerDriver",
      "connectionString":"jdbc:sqlserver://someserver:1433",
      "username":"myuser",    // These will be encrypted
      "password":"mypassword" //   in the next step
    }
  ]
}
```

Start CommandBox in current directory with ```box.exe``` and run the encryption task with ```task run tasks/setup```.
This task will overwrite the configuration file with encrypted credentials.

Start the server with ```server start```


## Commands
* Start server ```CommandBox> server start cfengine=lucee```
* Restart current server ```CommandBox> restart```
* View log ```CommandBox> server log --follow```
* All in one ```CommandBox> restart && server log --follow```


## To Do
* Allow tab in textarea (js)
* Display open file
* Save sql file - new
* Save sql file - open
* Favicon


## References
* CommandBox - https://www.ortussolutions.com/products/commandbox
* **Learn Modern ColdFusion in 100 Minutes** - https://modern-cfml.ortusbooks.com/
* Lucee Docs - https://docs.lucee.org/index.html
* Lucce CommandBox - https://docs.lucee.org/guides/getting-started/commandbox.html
* Lucee Tutorials - https://lucee.org/learn/tutorials.html
* Server reloading examples - https://gist.github.com/nicklepedde/3277959

