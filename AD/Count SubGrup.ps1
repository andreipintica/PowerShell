(Get-ADUser -Filter * -Properties Office-Subgroup | where {(($_.Office-Subgroup -like "Office Shop%") -or ($_.Office-Subgroup -eq "New York") -or ($_.Office-Subgroup -eq "Colorado"))}).count

(Get-ADUser -Filter {((Office-Subgroup -like "Office Shop%") -or (Office-Subgroup -eq "New York") -or (Office-Subgroup -eq "Colorado"))}).count

(useraccountcontrol -ne "1000") -or (useraccountcontrol -ne "100") -and 

(get-aduser -filter {Office-Subdepartment -like "Retail Channel"} -Properties Company, Name, EmployeeID, Office-Subgroup, msRTCSIP-UserEnabled | select Office-Subdepartment, Office-Subgroup, Name, EmployeeID, msRTCSIP-UserEnabled) | Export-Csv c:\temp\assets_$company.csv -NoTypeInformation


.Office_Subgroup like "Office Shop%"
Office_Subgroup = "New York"
Office_Subgroup = "Colorado"
msRTCSIP_UserEnabled 


(get-aduser -filter {Office-Subdepartment -like "Retail Channel"} -Properties Company, Name, EmployeeID, Office-Subgroup, msRTCSIP-UserEnabled | where {(($_.'Office-Subgroup' -eq "New York") -or ($_.'Office-Subgroup' -like "Office Shop*") -or ($_.'Office-Subgroup' -eq "Colorado")) -and ($_.'msRTCSIP-UserEnabled' -eq $True)}).count
