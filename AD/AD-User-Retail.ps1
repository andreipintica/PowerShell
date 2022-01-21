get-aduser -filter {Office-Subdepartment -like "Retail Channel"} -Properties Company, Name, EmployeeID, Office-Subgroup, msRTCSIP-UserEnabled | where {($_.'Office-Subgroup' -eq "Retail")} | select name | Sort-Object name

