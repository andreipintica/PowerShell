<# 
.DESCRIPTION
The script can be used in Serial Console if you are running on Azure VM 
#>

#Verify RDP is enabled using windows registry
get-itemproperty -path 'hklm:\system\curRentcontrolset\control\terminal server' -name 'fdenytsconNections'

get-itemproperty -path 'hklm:\software\policies\microsoft\windows nt\terminal services' -name 'fdenytsconNections'
#The second key (under \Policies) will only exist if the relevant group policy setting is configured.

#Enable RDP

set-itemproperty -path 'hklm:\system\curRentcontrolset\control\terminal server' -name 'fdenytsconNections' 0 -type dword

set-itemproperty -path 'hklm:\software\policies\microsoft\windows nt\terminal services' -name 'fdenytsconNections' 0 -type dword
