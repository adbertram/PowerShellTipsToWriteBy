#region Sign Scripts

New-SelfSignedCertificate -DnsName <your email> -CertStoreLocation Cert:\CurrentUser\My -Type Codesigning

Export-Certificate -FilePath codesigning.cer -Cert Cert:\CurrentUser\My\<thumbprint of certificate>
Import-Certificate -CertStoreLocation Cert:\LocalMachine\Root\ -FilePath .\codesigning.cer
Import-Certificate -CertStoreLocation Cert:\LocalMachine\TrustedPublisher\ -FilePath .\codesigning.cer

## This assumes there is only one code signing cert in the store
$cert = Get-ChildItem -Path Cert:\CurrentUser\My\ -CodeSigningCert
Set-AuthenticodeSignature -FilePath C:\Temp\script1.ps1 -Certificate $cert

#endregion

#region Never Store Sensitive Information in Clear Text in Code

$password = ConvertTo-SecureString 'MySecretPassword' -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ('root', $password)

$credential = Get-Credential

$credential | Export-CliXml -Path .\credential.xml

#endregion

#region Don’t Use Invoke-Expression

[CmdletBinding()]
param(
    [Parameter()]
    [string]$FormInput
)
## Do something with $FormInput

[CmdletBinding()]
param(
    [Parameter()]
    [string]$FormInput
)
Invoke-Expression -Command $FormInput

Remove-Item -Path 'C:\' -Recurse -Force

#endregion

#region Use PowerShell Constrained Language Mode

$ExecutionContext.SessionState.LanguageMode = "ConstrainedLanguage"

#endregion