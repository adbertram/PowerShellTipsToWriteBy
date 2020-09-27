#region Don’t Hardcode. Always Use Parameters

## restart-serverservice.ps1
Get-Service -ComputerName FOO -Name 'service1','service2' | Restart-Service

## restart-serverservice.ps1
[CmdletBinding()]
param(
    [Parameter()]
    [string]$ServerName,
    [Parameter()]
    [string[]]$ServiceName
)
Get-Service -ComputerName $ServerName -Name $ServiceName | Restart-Service

.\restart-serverservice.ps1 -ServerName FOO -ServiceName 'service1','service2'

## restart-serverservice.ps1
[CmdletBinding()]
param(
    [Parameter()]
    [string]$ServerName = 'FOO',
    [Parameter()]
    [string[]]$ServiceName = @('service1','service2')
)
Get-Service -ComputerName $ServerName -Name $ServiceName | Restart-Service



#endregion

#region Use Parameter Sets When All Parameters Should Not Be Used at Once

function Reboot-Server {
    param(
        [Parameter(Mandatory)]
        [string]$ServerName
    )
    if (Test-Connection -ComputerName $ServerName -Count ​-Quiet) {
        Restart-Computer -ComputerName $ServerName
    }
}

Reboot-Server -ServerName FOO

## RebootServer.psm1
#requires -Module ActiveDirectory
function Get-Server {
    param(
        [Parameter()]
        [string]$ServerName
    )
    ## If ServerName parameter was not used, pull computer names from AD
    if (-not ($PSBoundParameters.ContainsKey('ServerName'))) {
        $serverNames = Get-AdComputer -Filter * | Select-Object ​-ExpandProperty Name
    } else {
        $serverNames = $ServerName
    }
    ## send a custom object out to the pipeline for each server name found
    $serverNames | ForEach-Object {
        [pscustomobject]@{
            'ServerName' = $_
        }
    }
}

## Reboots all computers in AD. Ruh roh!
Get-Server | Reboot-Server

Reboot-Server -ServerName FOO

## RebootServer.psm1
function Reboot-Server {
    param(
        [Parameter(Mandatory)]
        [string]$ServerName,
        [Parameter(Mandatory, ValueFromPipeline)]
        [pscustomobject]$InputObject
    )
    process {
        if ($PSBoundParameters.ContainsKey('InputObject')) {
            $ServerName = $InputObject.ServerName
        }
        if (Test-Connection -ComputerName $ServerName -Count ​-Quiet) {
            Restart-Computer -ComputerName $ServerName
        }
    }
}

## RebootServer.psm1
function Reboot-Server {
    param(
        [Parameter(Mandatory,ParameterSetName = 'ServerName')]
        [string]$ServerName,
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'InputObject')]
        [pscustomobject]$InputObject
    )
    process {
        if ($PSBoundParameters.ContainsKey('InputObject')) {
            $ServerName = $InputObject.ServerName
        }
        if (Test-Connection -ComputerName $ServerName -Count ​-Quiet) {
            Restart-Computer -ComputerName $ServerName
        }
    }
}
#endregion

#region Use a PSCredential Object Rather Than a Separate Username and Password

## somescript.ps1
[CmdletBinding()]
param(
    [Parameter()]
    [string]$UserName,
    [Parameter()]
    [string]$Password
)
.\someapp.exe $UserName $Password

.\somescript.ps1 -UserName 'adam' -Password 'MySuperS3ct!pw!'

## somescript.ps1
[CmdletBinding()]
param(
    [Parameter()]
    [pscredential]$Credential
)
## You'll still have to decrypt the password here but you at least keep it
## secure for as long as you can
$cred = $Credential.GetNetworkCredential()
.\someapp.exe $cred.UserName $cred.Password

.\somescript.ps1 -Credential (Get-Credential)

#endregion

