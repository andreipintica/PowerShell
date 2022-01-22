#Local usage

Get-WmiObject Win32_BaseBoard 
Get-WmiObject win32_physicalmemory 
Get-WmiObject win32_diskdrive  | select model,serialnumber
Get-NetIPAddress | Select-Object IPv4Address
Get-WmiObject –Class Win32_ComputerSystem | Select-Object UserName 

#Remote usage

Get-WmiObject Win32_BaseBoard -ComputerName cc12
Get-WmiObject win32_physicalmemory -ComputerName cc12
Get-WmiObject win32_diskdrive -ComputerName cc12 | select model,serialnumber
Get-NetIPAddress | Select-Object IPv4Address
Get-WmiObject –ComputerName cc12 –Class Win32_ComputerSystem | Select-Object UserName 
