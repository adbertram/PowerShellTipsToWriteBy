#region DRY: Don’t Repeat Yourself

if (-not (Get-WindowsFeature -Name 'Web-Server').Installed) {
    Install-WindowsFeature -Name 'Web-Server'
}

if (-not (Get-WindowsFeature -Name 'Web-Server').Installed) {
    Install-WindowsFeature -Name 'Web-Server'
}
if (-not (Get-WindowsFeature -Name 'SNMP-Server').Installed) {
    Install-WindowsFeature -Name 'Web-Server'
}
if (-not (Get-WindowsFeature -Name 'SNMP-Services').Installed) {
    Install-WindowsFeature -Name 'Web-Server'
}
if (-not (Get-WindowsFeature -Name 'Backup-Features').Installed) {
    Install-WindowsFeature -Name 'Web-Server'
}
if (-not (Get-WindowsFeature -Name 'XPS-Viewer').Installed) {
    Install-WindowsFeature -Name 'Web-Server'
}
if (-not (Get-WindowsFeature -Name 'Wireless-Networking').Installed) {
    Install-WindowsFeature -Name 'Web-Server'
}

$featureNames = @(
    'Web-Server'
    'SNMP-Server'
    'SNMP-Services'
    'Backup-Features'
    'XPS-Viewer'
    'Wireless-Networking'
)
foreach ($name in $featureNames) {
    if (-not (Get-WindowsFeature -Name $name).Installed) {
        Install-WindowsFeature -Name $name
    }
}

#endregion

#region Don’t Store Configuration Items in Code

@{
    'WindowsFeatures' = @(
        'Web-Server'
        'SNMP-Server'
        'SNMP-Services'
        'Backup-Features'
        'XPS-Viewer'
        'Wireless-Networking'
    )
}

$configuration = Import-PowerShellDataFile "$PSScriptRoot\ScriptConfiguration.psd1"
foreach ($name in $configuration.WindowsFeatures) {
    if (-not (Get-WindowsFeature -Name $name).Installed) {
        Install-WindowsFeature -Name $name
    }
}

#endregion

#region Always Remove Dead Code

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$ComputerName,
    [Parameter()]
    [pscredential]$Credential
)
$somelostForgottenVariable = 'bar'
$service = Get-Service -Name 'foo' -ComputerName $ComputerName
if ($service.Status -eq 'Running') {
    Write-Host 'Do something here'
} elseif ($someLostForgottenVariable -eq 'baz') {
    Write-Host 'do something else here'
}



#endregion