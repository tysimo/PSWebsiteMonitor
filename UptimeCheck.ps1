param ([String]$Environment,[String]$Group) 
Import-Module ".\PSWebsiteMonitor.psm1"
UptimeCheck $Environment $Group