#region Write Functions with One, Single Goal

function Copy-ConfigurationFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$FilePath,
        [Parameter(Mandatory)]
        [string[]]$ServerName
    )
    foreach ($server in $ServerName) {
        if (Test-Connection -ComputerName $server -Quiet -Count 1) {
            Copy-Item -Path $FilePath -Destination "\\$server\c$"
        } else {
            Write-Warning "The server [$server] is offline. Unable to copy file."
        }
    }
}


#endregion

#region Build Functions with Pipeline Support
function Start-AppBackup {
    param(
        [Parameter()]
        [string]$ComputerName,
        [Parameter()]
        [string]$BackupLocation = '\\MYBACKUPSERVER\Backups'
    )
    Copy-Item -Path "\\$ComputerName\c$\Program Files\SomeApp\Database\*" -Destination "$BackupLocation\$ComputerName"
}
function Restore-AppBackup {
    param(
        [Parameter(Mandatory)]
        [string]$ComputerName,
        [Parameter()]
        [string]$BackupLocation = '\\MYBACKUPSERVER\Backups'
    )
    Copy-Item -Path "$BackupLocation\$ComputerName\*" -Destination "\\$ComputerName\c$\Program Files\SomeApp\Database"
}

Start-AppBackup -ComputerName FOO
Restore-AppBackup -ComputerName FOO

function Start-AppBackup {
    param(
        [Parameter()]
        [string]$ComputerName,
        [Parameter()]
        [string]$BackupLocation = '\\MYBACKUPSERVER\Backups'
    )
    Copy-Item -Path "\\$ComputerName\c$\Program Files\SomeApp\Database\*" -Destination "$BackupLocation\$ComputerName"
}
function Get-AppBackup {
    param(
        [Parameter(Mandatory)]
        [string]$ComputerName,
        [Parameter()]
        [string]$BackupLocation = '\\MYBACKUPSERVER\Backups'
    )
    [pscustomobject]@{
        'ComputerName' = $ComputerName
        'Backup'       = (Get-ChildItem -Path "\\$BackupLocation\$ComputerName")
    }
}
function Restore-AppBackup {
    param(
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [string]$ComputerName,
        [Parameter()]
        [string]$BackupLocation = '\\MYBACKUPSERVER\Backups'
    )
    Copy-Item -Path "$BackupLocation\$ComputerName\*" -Destination "\\$ComputerName\c$\Program Files\SomeApp\Database"
}

Get-AppBackup -ComputerName FOO | Restore-AppBackup
#endregion

#region Save Commonly Used, Interactive Functions to Your User Profile
function prompt { 'PS>' }

$Profile
#endregion