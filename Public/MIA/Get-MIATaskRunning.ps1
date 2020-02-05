function Get-MIATaskRunning
{
    [CmdletBinding()]
    param (
        [string]$Name,
        [string]$Fields,
        [int32]$Page,
        [int32]$PerPage

    )

    $query = BuildQueryFromPSBoundParameters($PSBoundParameters)
    $response = Invoke-MIARequest -Resource "tasks/running" -Query $query
    Write-MIAOutput -Response $response -Typename "MIREST.MIATaskRunning"
}