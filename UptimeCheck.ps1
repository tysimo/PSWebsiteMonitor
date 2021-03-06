$Path = Split-Path -parent $MyInvocation.MyCommand.Definition

[xml]$xml = get-content $Path\environment.xml
$Environment = $xml.environment
	
$Instance = $Environment."database-instance"
$Database = $Environment."database-name"
$MailServer = $Environment."mail-server"
$FromAddress = $Environment."mail-from-address"

$Results = Invoke-Sqlcmd -Query "select Name from [Group]" -ServerInstance $Instance -Database $Database

ForEach ($Result in $Results)
{
	$Groups = $Groups + $Result.Name + ","
}
$Groups = $Groups.split(',')

WorkFlow RunCheck
{
	param ($Groups, $Path, $Instance, $Database, $MailServer, $FromAddress)
	ForEach -Parallel ($Group in $Groups)
	{	
		inlineScript {Import-Module "$Using:Path\PSWebsiteMonitor.psm1" 
			UptimeCheck $Using:Group $Using:Instance $Using:Database $Using:MailServer $Using:FromAddress}
	}
}

Set-Location C:\
RunCheck $Groups $Path $Instance $Database $MailServer $FromAddress