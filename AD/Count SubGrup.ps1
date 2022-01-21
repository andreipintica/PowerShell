(Get-ADUser -Filter * -Properties Office-Subgroup | where {(($_.Office-Subgroup -like "Office Shop%") -or ($_.Office-Subgroup -eq "Cluj") -or ($_.Office-Subgroup -eq "Suceava"))}).count

(Get-ADUser -Filter {((Office-Subgroup -like "Office Shop%") -or (Office-Subgroup -eq "Cluj") -or (Office-Subgroup -eq "Suceava"))}).count

(useraccountcontrol -ne "66050") -or (useraccountcontrol -ne "514") -and 

(get-aduser -filter {Office-Subdepartment -like "Retail Channel"} -Properties Company, Name, EmployeeID, Office-Subgroup, msRTCSIP-UserEnabled | select Office-Subdepartment, Office-Subgroup, Name, EmployeeID, msRTCSIP-UserEnabled) | Export-Csv c:\temp\assets_$company.csv -NoTypeInformation


.Office_Subgroup like "Office Shop%"
Office_Subgroup = "Cluj"
Office_Subgroup = "Suceava"
msRTCSIP_UserEnabled 


(get-aduser -filter {Office-Subdepartment -like "Retail Channel"} -Properties Company, Name, EmployeeID, Office-Subgroup, msRTCSIP-UserEnabled | where {(($_.'Office-Subgroup' -eq "Cluj") -or ($_.'Office-Subgroup' -like "Office Shop*") -or ($_.'Office-Subgroup' -eq "Suceava")) -and ($_.'msRTCSIP-UserEnabled' -eq $True)}).count