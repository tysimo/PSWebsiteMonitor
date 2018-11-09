# PSWebsiteMonitor

PowerShell module for website monitoring.

Get alerts via email and sms.


# Installation

### Step 1

Download zip or clone repo (https://github.com/tysimo/PSWebsiteMonitor.git).

### Step 2

Create SQL database by running `.\sql\create-database.sql` on desired SQL instance. 

Add Group records to database.  Use `.\sql\insert-group-records.sql` as a template.

Add URLs records to database.  Use `.\sql\insert-url-records.sql` as a template.


### Step 3

Configure `database-instance`, `mail-server`, and `mail-from-address` values in `.\environment.xml`.
```
<environment>
	<database-instance></database-instance>
	<database-name>PSWebsiteMonitor</database-name> 
	<mail-server></mail-server>  
	<mail-from-address></mail-from-address>
</environment>
```

### Step 4

Create Windows scheduled task.

Open a new PowerShell session as an administrator and `cd` to the PSWebsiteMonitor folder. Run the below command to create the Windows scheduled task.
```
.\CreateScheduledTask.ps1
```
By default the task will run every minute to check URLs.
