Import-csv -Path c:\temp\mail.csv -delimiter ";" | ForEach {
Get-ADUser -Filter "EmailAddress -eq '$($_.email)'" -Properties EmailAddress 
} | Select-Object name | Export-Csv c:\temp\mail_$company.csv -NoTypeInformation