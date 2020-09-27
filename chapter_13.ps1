#region Use Native PowerShell Where Possible

$text = [System.IO.File]::ReadAllText('C:\textfile.txt')
## Do some stuff with the string in $text here

$text = Get-Content -Path 'C:\textfile.txt' -Raw
## Do some stuff with the string in $text here

#endregion