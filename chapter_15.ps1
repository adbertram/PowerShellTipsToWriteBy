#region Use Progress Bars Wisely

## Pull server computer names from AD
$serverNames = Get-AdComputer -Filter '*' -SearchBase 'OU=Servers,DC=company,DC=local' | Select-Object -ExpandProperty Name
foreach ($name in $serverNames) {
    foreach ($file in Get-ChildItem -Path "\\$name\c$\SomeFolderWithABunchOfFiles" -File) {
        ## Read and do stuff to each one of these files
    }
}

## Pull server computer names from AD
$serverNames = Get-AdComputer -Filter '*' -SearchBase 'OU=Servers,DC=company,DC=local' | Select-Object -ExpandProperty Name
## Process each server name
for ($i=0;$i -lt $serverNames.Count;$i++) {
    Write-Progress -Activity 'Processing files' -Status "Server [$($serverNames[$i])]" -PercentComplete (($i / $serverNames.Count) * 100)
    ## Process each file on the server
        foreach ($file in Get-ChildItem -Path "\\$($serverNames[$i])\c$\SomeFolderWithABunchOfFiles" -File) {
        ## Read and do stuff to each one of these files
    }
}

#endregion

#region Leave the Format Cmdlets to the Console

## readsomefiles.ps1
Get-ChildItem -Path 'somepath\here' | Format-Table

## readsomefiles.ps1
Get-ChildItem -Path 'somepath\here' | Format-Table | Remove-Item

.\readsomefiles.ps1 | Format-Table

#endregion

#region Use Write-Verbose

#requires -Module ActiveDirectory
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string[]]$DnsHostname,
    [Parameter()]
    [string]$DomainName = (Get-ADDomain).Forest
)
$Path = "AD:\DC=$DomainName,CN=MicrosoftDNS,DC=ForestDnsZones,DC=$($DomainName.Split('.') -join ',DC=')"
foreach ($Record in (Get-ChildItem -Path $Path)) {
    if ($DnsHostname -contains $Record.Name) {
        Get-Acl -Path "ActiveDirectory:://RootDSE/$($Record.DistinguishedName)"
    }
}

#requires -Module ActiveDirectory
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string[]]$DnsHostname,
    [Parameter()]
    [string]$DomainName = (Get-ADDomain).Forest
)
Write-Verbose -Message 'Starting script...'
$Path = "AD:\DC=$DomainName,CN=MicrosoftDNS,DC=ForestDnsZones,DC=$($DomainName.Split('.') -join ',DC=')"
foreach ($Record in (Get-ChildItem -Path $Path)) {
    if ($DnsHostname -contains $Record.Name) {
        Write-Verbose -Message "Getting ACL for [$($Record.Name)]..."
        Get-Acl -Path "ActiveDirectory:://RootDSE/$($Record.DistinguishedName)"
        Write-Verbose -Message "Finished getting ACL for [$($Record.Name)]."
    }
}
Write-Verbose -Message 'Script ending...'

#endregion

#region Use Write-Information

#requires -Module ActiveDirectory
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string[]]$DnsHostname,
    [Parameter()]
    [string]$DomainName = (Get-ADDomain).Forest
)
Write-Information -MessageData 'Starting script...'
$Path = "AD:\DC=$DomainName,CN=MicrosoftDNS,DC=ForestDnsZones,DC=$($DomainName.Split('.') -join ',DC=')"
foreach ($Record in (Get-ChildItem -Path $Path)) {
    if ($DnsHostname -contains $Record.Name) {
        Write-Verbose -Message "Getting ACL for [$($Record.Name)]..."
        Get-Acl -Path "ActiveDirectory:://RootDSE/$($Record.DistinguishedName)"
        Write-Verbose -Message "Finished getting ACL for [$($Record.Name)]."
    }
}
Write-Information -MessageData 'Script ending...'

#endregion

#region Ensure a Command Returns One Type of Object

$servers = ('SRV1','SRV2','SRV3','SRV4')
foreach ($server in $servers) {
    Get-Service -ComputerName $server
    Get-ChildItem -Path "\\$server\c$\Users" -Directory
}

$servers = ('SRV1','SRV2','SRV3','SRV4')
foreach ($server in $servers) {
    $services = Get-Service -ComputerName $server
    $userProfiles = Get-ChildItem -Path "\\$server\c$\Users" -Directory
    [pscustomobject]@{
        Services = $services
        UserProfiles = $userProfiles
    }
}

#endregion

#region Only Return Necessary Information to the Pipeline

New-Item -Path 'C:\path\to\folder' -ItemType Directory

$null = New-Item -Path 'C:\path\to\folder' -ItemType Directory

#endregion