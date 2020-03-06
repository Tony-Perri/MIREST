function Get-MITFolderAcl
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Id,
        [int32]$Page,
        [int32]$PerPage,
        [ValidateSet('name', 'type', 'path')]
        [string]$SortField,
        [ValidateSet('ascending', 'descending')]
        [string]$SortDirection
    )

    $body = Convert-PSBoundToRequestBody $PSBoundParameters -KeysToExclude 'Id'
    $response = Invoke-MITRequest -Resource "folders/$Id/acls" -Query $query
    Write-MITOutput -Response $response -Typename 'MIREST.MITFolderAcl'

}