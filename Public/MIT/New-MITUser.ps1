function New-MITUser
{
    [CmdletBinding()]
    param (
        [string]$SourceUserId,
        [string]$FullName,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Username,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Password,
        [string]$Email,
        [ValidateSet('TemporaryUser', 'User', 'FileAdmin', 'Admin', 'SysAdmin')]
        [string]$Permission,
        [bool]$ForceChangePassword,
        [int32]$OrgID,
        [string]$Notes,
        [string]$HomeFolderPath,
        [ValidateSet('AllowIfExists', 'DenyIfExists')]
        [string]$HomeFolderInUseOption
    )

    $body = BuildQueryFromPSBoundParameters($PSBoundParameters)
    $response = Invoke-MITRequest -Method 'Post' -Resource "users" -Body $body
    Write-MITOutput -Response $response -Typename "MIREST.MITUserSimple"
}