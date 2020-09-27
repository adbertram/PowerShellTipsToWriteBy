#region Learn the Pester Basics

describe 'My computer tests' {
    it 'my computer name is what I expect it to be' {
        $env:COMPUTERNAME | should be 'PSGOD'
    }
}

Invoke-Pester -Path '~\Tests\mycomputer.tests.ps1'

#endregion

#region Use PSScriptAnalyzer

Function Gather-OperatingSystem {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        $ComputerName = $env:COMPUTERNAME
    )
    Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $ComputerName
}
Gather-OperatingSystem

Invoke-ScriptAnalyzer -Path ~\PathToScript\Gather-OperatingSystem.ps1

#endregion