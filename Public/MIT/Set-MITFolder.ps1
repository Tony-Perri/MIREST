function Set-MITFolder
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Id,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )

    $body = Convert-PSBoundToRequestBody $PSBoundParameters -KeysToExclude 'Id'
    $response = Invoke-MITRequest -Method 'Patch' -Resource "folders/$Id" -Body $body
    Write-MITOutput -Response $response -Typename "MIREST.MITFolderSimple"
}