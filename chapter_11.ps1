#region Force Hard-Terminating Errors

$someFile = Get-Item -Path 'a file that does not exist'
$acl = Get-Acl -Path $someFile.FullName
Set-Acl -Path 'a file that exists' -AclObject $acl

$someFile = Get-Item -Path 'a file that does not exist' -ErrorAction Stop
$acl = Get-Acl -Path $someFile.FullName
Set-Acl -Path 'a file that exists' -AclObject $acl

try {
    $someFile = Get-Item -Path 'a file that does not exist' -ErrorAction Stop
    $acl = Get-Acl -Path $someFile.FullName
    Set-Acl -Path 'a file that exists' -AclObject $acl
} catch {
    Write-Warning -Message $_.Exception.Message
}

$ErrorActionPreference = 'Stop'
try {
    $someFile = Get-Item -Path 'a file that does not exist'
    $acl = Get-Acl -Path $someFile.FullName
    Set-Acl -Path 'a file that exists' -AclObject $acl
} catch {
    Write-Warning -Message $_.Exception.Message
}

#endregion

#region Avoid Using $?

$someFile = Get-Item -Path 'a file that does not exist' -ErrorAction Ignore
if (-not $?) {
    Write-Warning -Message $_.Exception.Message
} else {
    $acl = Get-Acl -Path $someFile.FullName
    Set-Acl -Path 'a file that exists' -AclObject $acl
}

#endregion