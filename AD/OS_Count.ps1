$days = 90 
$lastLogonDate = (Get-Date).AddDays(-$days).ToFileTime()
Get-ADComputer -Filter * -Property * | Select-Object OU=Computers*,Name,OperatingSystem,OperatingSystemVersion,lastlogondate | Export-CSV C:\temp\AllWindows.csv -NoTypeInformation -Encoding UTF8