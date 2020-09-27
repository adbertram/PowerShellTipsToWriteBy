#region Explicitly Type All Parameters

function Get-Thing {
    param(
        $Param
    )
}

function Get-Thing {
    param(
        $Param
    )
    Write-Host "The property Foo's value is [$($Param.Foo)]"
}

function Get-Thing {
    param(
        [pscustomobject]$Param
    )
    Write-Host "The property Foo's value is [$($Param.Foo)]"
}

#endregion

#region Always Use Parameter Validation When Possible

$departments = 'ACCT', 'HR', 'ENG'

function New-ServerName {
    param(
        [Parameter()]
        [string]$Department
    )
    "$Department-$(Get-Random -Maximum 99)"
}

function New-ServerName {
    param(
        [Parameter()]
        [ValidateSet('ACCT','HR','ENG')]
        [string]$Department
    )
    "$Department-$(Get-Random -Maximum 99)"
}

New-ServerName -Department 'Software Engineering'

#endregion

#region Always Define a Function’s OutputType

function Get-File {
    param(
        [Parameter()]
        [string]$FilePath
    )
    Get-Item -Path $FilePath
}

$file = Get-File -FilePath C:\Test-PendingReboot.ps1

Get-File -Path 'C:\myfile.txt' | Get-Member

function Get-File {
    [OutputType([System.String])]
    param(
        [Parameter()]
        [string]$FilePath
    )
    Get-Item -Path $FilePath
}

#endregion

#region Write Specific Regular Expressions

'(\{){0,1}[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}(\}){0,1}'

'^.{8}-.{4}-.{4}-.{4}-.{12}$'

'michael' -match 'Michael'

'michael' -cmatch 'Michael'


#endregion