Function UptimeCheck ($Group, $Instance, $Database, $MailServer, $FromAddres)
{
	$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
	[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols

	$URLs = Invoke-SQLCmd -Query "select u.id as id, url, description, failcount, g.notificationlist as notificationlist, timeout, lasthealthycheck from url u inner join [group] g on u.group_id = g.id where active = 1 and name = '$Group'" -ServerInstance $Instance -Database $Database
	
	ForEach ($URL in $URLs)
	{
		$ID = $URL.id
		$FailCount = $URL.failcount
		$Description = $URL.description
		$Timeout = $URL.timeout
		$LastHealthyCheck = $URL.lasthealthycheck
		$NotificationList = $URL.notificationlist
		$NotificationList = $NotificationList.split(",")
		$URL = $URL.url
		
		Try
		{
			$Request = Invoke-WebRequest $URL -TimeoutSec $Timeout -UseBasicParsing
			$Status = $Request.StatusCode
			Invoke-SQLCmd -Query "update URL set status = '$Status', lastcheck = getdate(), failcount = 0, lasthealthycheck = getdate() where url = '$URL'" -ServerInstance $Instance -Database $Database
		}  
		Catch
		{
			If ($FailCount % 2 -eq 1)
			{
				$Status = $_.Exception
				$Status = $Status -replace "'",""
				$Now = Get-Date
				$TimeDiff = $Now - $LastHealthyCheck

				$Body = "<strong>URL:</strong><br><a href=""$URL"">$URL</a><br><br><strong>Response:</strong><br>$Status<br><br><strong>Last Healthy Check:</strong><br>$LastHealthyCheck"
				Send-MailMessage -from $FromAddress -to $NotificationList -subject "URL Alert: $URL ($Description $Group)" -bodyashtml -body $Body -smtpServer $MailServer
				Invoke-SQLCmd -Query "declare @failcount int; select @failcount = failcount + 1 from url where url = '$URL'; update URL set status = '$Status', lastcheck = getdate(), failcount = @failcount where url = '$URL'; insert into log (URL_ID, Response, CreatedOn, FailCount) values ('$ID', '$Status', getdate(), @failcount)" -ServerInstance $Instance -Database $Database
			}
		}
	}
}