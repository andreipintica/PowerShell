$Users = Import-Csv "c:\Temp\Marca_retail.csv"
#ForEach ($Marca In $Users) Get-ADUser -Filter "EmployeeID -eq $($Users.Marca)" -Properties Name | select Name | Export-Csv C:\temp\user.csv -NoTypeInformation
#Get-ADUser -Filter * -Properties Name,Title,mail,Office-DirectManager,Company,Office-Department,employeeID,office,Enabled,LastLogonDate | select SAmAccountName,Name,Title,mail,Office-DirectManager,Company,Office-Department,EmployeeID,office,Enabled,LastLogonDate, | Export-Csv C:\temp\user.csv -NoTypeInformation
foreach($user in $users)
{ 
    Get-ADUser -Filter "EmployeeID -eq $($user.Marca)" -Properties SAMAccountName, EmployeeID | select SAMAccountName, EmployeeID #| Export-csv C:\temp\UserRetail.csv -NoTypeInformation 
}