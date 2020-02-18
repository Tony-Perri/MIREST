function New-MIATask
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [psobject]$Task
    )

    $response = Invoke-MIARequest -Method 'Post' -Resource 'tasks' -Body $Task
    Write-MIAOutput -Response $response -Typename 'MIREST.MIATask'
}