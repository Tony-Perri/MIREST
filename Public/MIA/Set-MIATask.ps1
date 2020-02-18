function Set-MIATask
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$TaskId,
        [Parameter(Mandatory)]
        [psobject]$Task
    )

    $response = Invoke-MIARequest -Method 'Put' -Resource "tasks/$TaskId" -Body $Task
    Write-MIAOutput -Response $response -Typename 'MIREST.MIATask'
}