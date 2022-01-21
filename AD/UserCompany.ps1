get-aduser -filter {Company -like "MyCompany"} -Properties Company, Name, EmployeeID | select Company, Name, EmployeeID
