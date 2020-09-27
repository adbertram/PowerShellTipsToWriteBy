#region Don’t Use the Pipeline

$array = 0..1000000

Measure-Command -Expression {$null = $array.foreach({$_})}

Measure-Command -Expression {$array | foreach-object { $_ }}

#endregion

#region Use the foreach Statement in PowerShell Core

$array = 0..1000000
Measure-Command -Expression { $null = foreach ($item in $array) { $item }}
Measure-Command -Expression { $null = $array.foreach({$_})}

#endregion

#region Use Parallel Processing

## servers.txt
SRV1
SRV2
SRV3

$servers = Get-Content -Path C:\Servers.txt
Invoke-Command -ComputerName $servers -ScriptBlock {
    ## Do something on the server here
}

$servers = Get-Content -Path C:\Servers.txt
Invoke-Command -ComputerName $servers -AsJob -ScriptBlock {
    ## Do something on the server here
}

#endregion

#region Use the .NET StreamReader Class When Reading Large Text Files

Get-Content -Path C:\MyHugeFile.txt

$sr = New-Object -Type System.IO.StreamReader -ArgumentList 'C:\MyHugeFile.txt'
while ($sr.Peek() -ge 0) {
    $sr.ReadLine()
}

#endregion