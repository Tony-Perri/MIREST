function Get-MIAInfo
{
    [CmdletBinding()]
    param(

    )

    $response = Invoke-MIARequest -Resource "info"
    Write-MIAOutput $response -Typename 'MIREST.MIAInfo'
}