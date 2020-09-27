#region Write for Cross-Platform

ls -Path 'C:\SomeFolder' | ForEach-Object { $_.Encrypt() }

#endregion

#region Don’t Query the Win32_Product CIM Class

Get-CimInstance -Class Win32_Product

#endregion

#region Store “Formattable” Strings for Later Use

'Hi, I am {0} {1}' -f 'Adam','Bertram'

$FString = "SELECT * FROM some.dbo WHERE Hostname = '{0}'"
"comp1","comp2" | ForEach-Object {
    Invoke-SQLcmd -Query ($FString -f $_)
}

#endregion

#region Use Out-GridView for GUI-Based Sorting and Filtering

Get-Service | Out-GridView

#endregion

#region Don’t Make Automation Scripts Interactive

function Do-Thing {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Foo
    )        
              
}

Do-Thing

function Do-Thing {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Foo
    )
    $thing = Read-Host -Prompt 'I need some input!'
    ## Do stuff with $thing            
              
}

Do-Thing

$credential = Get-Credential -Message 'Needs some love here'

#endregion