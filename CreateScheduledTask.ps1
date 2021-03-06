$Path = Split-Path -parent $MyInvocation.MyCommand.Definition
$Start = (Get-Date).AddMinutes(1).ToString("HH:mm")
$Name = "PSWebsiteMonitor"
$Repeat = (New-TimeSpan -Minutes 1)
$Action = New-ScheduledTaskAction -Execute "PowerShell" -Argument ".\UptimeCheck.ps1" -WorkingDirectory $Path
$Duration = (New-TimeSpan -Days 1000)
$Trigger = New-ScheduledTaskTrigger -Once -At $Start -RepetitionInterval $Repeat -RepetitionDuration $Duration
$Prompt = "Enter the username and password that will run the task"; 
$Credential = $Host.UI.PromptForCredential("Task username and password",$Prompt,"$env:userdomain\$env:username",$env:userdomain)
$Username = $credential.UserName
$Password = $credential.GetNetworkCredential().Password
$Settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd

Register-ScheduledTask -TaskName $Name -Action $Action -Trigger $Trigger -RunLevel Highest -User $Username -Password $Password -Settings $Settings | out-null
