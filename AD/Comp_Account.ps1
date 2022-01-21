ForEach ($Computer in (get-content "C:\temp\Computers.txt")) 
{   Try {
        Get-ADComputer $Computer -ErrorAction Stop
        $Result = $true
    }
    Catch {
        $Result = $False
    }
    [PSCustomObject]@{
        Name = $server
        Found = $Result
    }
}
select Name,Enabled | Export-csv -path C:\temp\computer.csv -NoTypeInformation 