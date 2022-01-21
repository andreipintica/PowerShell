Get-ADComputer "C:\Temp\servers2.txt" -Filter * -properties Name,DistinguishedName, DNSHostName, OperatingSystem, Username
foreach ($computer in (Get-Content C:\temp\servers2c.txt)){
 write-verbose "Working on $computer..." -Verbose
 reg query "HKEY_CLASSES_ROOT\Excel.Application\CurVer"
 }
Export-CSV Select-Object Name,DistinguishedName, DNSHostName, OperatingSystem, Username | C:\Temp\tifui.csv


 
