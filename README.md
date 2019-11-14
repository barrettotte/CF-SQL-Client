# CF-SQL-Client

A simple browser SQL client for DB2 and MSSQL written with Lucee.
This was made to just screw around with Lucee and some SQL.


## Features
* Selectable datasource
* Detect datasource type - DB2,MSSQL,Unknown
* Enter SQL string in textbox with Syntax highlighting
* Execute SQL string
* Basic error handling
* Pretty print resultsets with Bootstrap
* Basic database browser - schemas, tables, procs, system info, etc.


## Setup
After cloning the application, datasource credentials within **config.json** are in plaintext until the application is run for the first time.
When its run for the first time, the credentials are encrypted with an AES key and injected back into the configuration file.
All future executions will already have the encrypted credentials and use the stored AES key.


## Commands
* Start server ```CommandBox> server start cfengine=lucee```
* Restart current server ```CommandBox> restart```
* View log ```CommandBox> server log --follow```
* All in one ```CommandBox> restart && server log --follow```


## References
* CommandBox - https://www.ortussolutions.com/products/commandbox
* **Learn Modern ColdFusion in 100 Minutes** - https://modern-cfml.ortusbooks.com/
* Lucee Docs - https://docs.lucee.org/index.html
* Lucce CommandBox - https://docs.lucee.org/guides/getting-started/commandbox.html
* Lucee Tutorials - https://lucee.org/learn/tutorials.html

