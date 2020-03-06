function New-MITFolder
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Id,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [ValidateSet('None','CopyOnly','Always')]
        [string]$InheritPermissions
    )

    $body = Convert-PSBoundToRequestBody $PSBoundParameters -KeysToExclude 'Id'
    $response = Invoke-MITRequest -Method 'Post' -Resource "folders/$Id/subfolders" -Body $body
    Write-MITOutput -Response $response -Typename "MIREST.MITFolderSimple"
}