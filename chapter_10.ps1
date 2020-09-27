#region Give Your Variables Meaningful Names

$t = 'servers.txt'
$x = Get-Content -Path $t
foreach ($r in $x) {
    Invoke-Command -ComputerName $r -ScriptBlock {'Doing something on this computer'}
}

$serversFilePath = 'servers.txt'
$serverNames = Get-Content -Path $serversFilePath
foreach ($serverName in $serverNames) {
    Invoke-Command -ComputerName $serverName -ScriptBlock {'Doing something on this computer'}
}

#endregion

#region String Substitution

$departments = @(
    'HR'
    'ACCT'
    'ENG'
)

foreach ($dept in $departments) {
    $srvName = "$dept-SRV"
    $srvName
}

foreach ($dept in $departments) {
    $srvName = '{0}-SRV' -f $dept
    $srvName
}

#endregion

#region Write Comment-Based Help

function Get-ConfigurationFile {
    <#
    .SYNOPSIS
        Finds the configuration file for the Acme application.
    .DESCRIPTION
        This function attempts to find the configuration file for Acme application
            based on the path provided. If found, it then returns a file object to then
            pass to other functions to manipulate the configuration file.
    .EXAMPLE
        PS C:\> Get-ConfigurationFile -FilePath 'C:\Program Files\AcmeApp\config.xml'
            This example will look for the configuration file at C:\Program Files\AcmeApp\config.xml
            and, if found, will return a file object.
    .OUTPUTS
        System.IO.FileInfo
    #>
    param(
        [Parameter()]
        [string]$FilePath
    )
    ## Some code here that looks for the configuration file
}

#endregion

#region Weigh the Difference Between Performance and Readability

$array = 0..100

$array += 101

$arrayList = [System.Collections.ArrayList](0..100)
$arrayList.Add(101)




#endregion