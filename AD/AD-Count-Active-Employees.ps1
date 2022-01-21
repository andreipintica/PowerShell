$start_date =  get-date('11/01/2011') -Format 'yyyy-MM-dd HH:mm:ss'
$end_date =  get-date('11/30/2011') -Format 'yyyy-MM-dd HH:mm:ss'



$users = get-aduser -Filter * -Properties accountexpires,employeeid,whencreated,company
$users = $users | ? {$_.distinguishedname -notlike "*,OU=AdministrativeAccounts,DC=office"}
$usergroup = @()

foreach ($user in $users) {
  $lngValue = $User.AccountExpires
  [int]$marca = $user.employeeid

  if ($marca -gt 0 -and $user.whencreated -lt $end_Date) {
    # A value of 0 or 2^63-1 means never.
    If ($lngValue -gt [DateTime]::MaxValue.Ticks)
    {
      $lngValue = 0
    }
    # Convert 64-bit integer into DateTime.
    $Date = [DateTime]$lngValue
    If ($Date -eq 0)
    {
          $entry = new-object psobject -Property @{
                      User = $user.samaccountname
                      Company = $user.company
                      }
          $usergroup += $entry
    }
    Else
    {
      # Convert Active Directory ticks to PowerShell ticks.
      # Also convert from UTC to local time.
      $AcctExpires = $Date.AddYears(1600).ToLocalTime()
      if ($AcctExpires -gt $start_date) {
          $entry = new-object psobject -Property @{
                User = $user.samaccountname
                Company = $user.company
                }
          $usergroup += $entry
      }
    }
 
  }  
}

write-host "Total Users: $($usergroup.count)"
$usergroup | Group-Object -Property company | select name,count





