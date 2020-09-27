#region Use a Logging Function

Add-Content -Path 'C:\activity.log' -Value "Doing something here"

function Write-Log {
    [CmdletBinding()]
    <#
        .SYNOPSIS
            This function creates or appends a line to a log file
        
        .DESCRIPTION
            This function writes a line to a log file            
              
        .PARAMETER Message
            The message parameter is the log message you'd like to record to the log file.            
              
        .PARAMETER LogLevel              
            The logging level is the severity rating for the message you're recording.
            You have 3 severity levels available; 1, 2 and 3 from informational messages
            for FYI to critical messages. This defaults to 1.
              
        .EXAMPLE              
            PS C:\> Write-Log -Message 'Valuell -LogLevel "Value2'
    
            This example shows how to call the Write-Log function with named parameters.
    #>        
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Message,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$FilePath = "$PSScriptRoot\activity.log",

        [Parameter()]
        [ValidateSet(1, 2, 3)]
        [int]$LogLevel = 1
    )
    [pscustomobject]@{
        'Time'     = (Get-Date -Format 'MM-dd-yy HH:mm:sstt')
        'Message'  = $Message
        'Source'   = "$($MyInvocation.ScriptName | Split-Path -Leaf):$($MyInvocation.ScriptLineNumber)"
        'Severity' = $LogLevel
    } | Export-Csv -Path $FilePath -Append -NoTypeInformation
}

#endregion

#region Clean Up Verbose Messages

[CmdletBinding()]
param(
    [Parameter()]
    [string]$ComputerName,
    [Parameter()]
    [string]$FilePath
)
Get-Content -Path "\\$ComputerName\$FilePath"

## read-file.ps1
[CmdletBinding()]
param(
    [Parameter()]
    [string]$ComputerName,
    [Parameter()]
    [string]$FilePath
)
Write-Verbose -Message "Attempting to read file at [\\$ComputerName\$FilePath]..."
Get-Content -Path "\\$ComputerName\$FilePath"

./read-file.ps1 -ComputerName FOO -FilePath 'bar.txt' -Verbose



#endregion