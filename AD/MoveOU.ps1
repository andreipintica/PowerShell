[CmdletBinding()]
Param(
#  [Parameter(Mandatory=$True,Position=1)]
    [Parameter(Mandatory=$false,Position=1)]
    [string]$WebService = "https://office.intra/adtools/adtoolbox.asmx",
    
    [Parameter(Mandatory=$false)]
    [switch]$dbg = $false

)

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# Init
$CurrentHostName = $env:COMPUTERNAME

$NewComputerOU = $null
$CurrentADSIData = $null

$res = $null

# retreive DN
$CurrentADSIData = ([adsisearcher]"(cn=$($CurrentHostName))").findall()

If ($CurrentADSIData)
{
    Write-Host "Find Object : $($CurrentADSIData.path)"
}
else
{
     Write-Host "Computer Object Not Found : " -ForegroundColor Red
}
# -----------------------------------------------------------------------------
# define New OU
$NewComputerOU = ($CurrentADSIData.path -replace ("V4","V5")) -Replace "CN=$CurrentHostName,", ""
if($NewComputerOU.Contains("OU=_Computers_v5_pilot")) {
	$NewComputerOU = $NewComputerOU -Replace "OU=_Computers_v5_pilot" , "OU=_Computers_v5_staging"	
}
else {
	$NewComputerOU = $NewComputerOU -Replace "OU=Computers_v5" , "OU=_Computers_v5_staging,OU=Computers_v5"
}

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# retreive another info
$DomainName = ($CurrentADSIData.Properties.dnshostname) -replace "$($CurrentHostName).",""
$NewComputerOU = $NewComputerOU.Replace( ",DC=" + $DomainName.Replace(".", ",DC="), "").Replace("LDAP://", "")

$CurrentDCHostname = (Get-WmiObject -Class win32_ntdomain -Filter "DnsForestName ='$($DomainName)'").DomainControllerName -replace '\\',''
# -----------------------------------------------------------------------------
write-host "Try to move in staging OU : $($NewComputerOU)"

if (!( [System.Uri]::TryCreate($WebService,[System.UriKind]::Absolute,[ref]$res)))
{
    # use default value 
    [string]$WebService = "https://office.intra/adtools/adtoolbox.asmx"

}
# -----------------------------------------------------------------------------

try
{
    $Proxy = New-WebserviceProxy -Uri $WebService -UseDefaultCredential
    $Proxy.url = $WebService
    $return = $Proxy.MoveComputer("$($CurrentHostName)","$($CurrentDCHostname)","$($DomainName)","$($NewComputerOU)")
	exit 0
}
Catch
{
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
# -----------------------------------------------------------------------------