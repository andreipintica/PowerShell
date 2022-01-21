Import-Module activedirectory
Clear-Host
function Get-LocalAdminToCsv {
    Param(
            $Path          = (Get-ADDomain).DistinguishedName,   
            $ComputerName  = (Get-ADComputer -Filter * -Server (Get-ADDomain).DNsroot -SearchBase $Path -Properties Enabled | Where-Object {$_.Enabled -eq "True"})
         )

    begin{
        [array]$Table = $null
        $Counter = 0
         }
    
    process
    {
    $Date       = Get-Date -Format MM_dd_yyyy_HH_mm_ss
    $FolderName = "LocalAdminsReport("+ $Date + ")"
    New-Item -Path ".\$FolderName" -ItemType Directory -Force | Out-Null

        foreach($Computer in $ComputerName)
        {
            try
            {
                $PC      = Get-ADComputer $Computer
                $Name    = $PC.Name
                $CountPC = @($ComputerName).count
            }

            catch
            {
                Write-Host "Cannot retrieve computer $Computer" -ForegroundColor Yellow -BackgroundColor Red
                Add-Content -Path ".\$FolderName\ErrorLog.txt" "$Name"
                continue
            }

            finally
            {
                $Counter ++
            }

            Write-Progress -Activity "Connecting PC $Counter/$CountPC " -Status "Querying ($Name)" -PercentComplete (($Counter/$CountPC) * 100)

            try
            {
                $row = $null
                $members =[ADSI]"WinNT://$Name/Administrators"
                $members = @($members.psbase.Invoke("Members"))
                $members | foreach {
                            $User = $_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)
                                    $row += $User
                                    $row += " ; "
                                    }
                write-host "Computer ($Name) has been queried and exported." -ForegroundColor Green -BackgroundColor black 
                
                $obj = New-Object -TypeName PSObject -Property @{
                                "Name"           = $Name
                                "LocalAdmins"    = $Row
                                                    }
                $Table += $obj
            }

            catch
            {
            Write-Host "Error accessing ($Name)" -ForegroundColor Yellow -BackgroundColor Red
            Add-Content -Path ".\$FolderName\ErrorLog.txt" "$Name"
            }

            
        }
        try
        {
            $Table  | Sort Name | Select Name,LocalAdmins | Export-Csv -path ".\$FolderName\Report.csv" -Append -NoTypeInformation
        }
        catch
        {
            Write-Warning $_
        }
    }

    end{}
   }
    