$Users = Import-Csv "c:\Temp\EID_retail.csv"
#ForEach ($Eid In $Users) Get-ADUser -Filter "EmployeeID -eq $($Users.Eid)" -Properties Name | select Name | Export-Csv C:\temp\user.csv -NoTypeInformation
#Get-ADUser -Filter * -Properties Name,Title,mail,Office-DirectManager,Company,Office-Department,employeeID,office,Enabled,LastLogonDate | select SAmAccountName,Name,Title,mail,Office-DirectManager,Company,Office-Department,EmployeeID,office,Enabled,LastLogonDate, | Export-Csv C:\temp\user.csv -NoTypeInformation
foreach($user in $users)
{ 
    Get-ADUser -Filter "EmployeeID -eq $($user.Eid)" -Properties SAMAccountName, EmployeeID | select SAMAccountName, EmployeeID #| Export-csv C:\temp\UserEid.csv -NoTypeInformation 
}
