#Local usage
Get-WmiObject win32_diskdrive | select model,serialnumber

#Remote usage
Get-WmiObject win32_diskdrive -ComputerName MY-PCname | select model,serialnumber
