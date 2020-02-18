function Remove-MIATask
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$TaskId
    )

    $response = Invoke-MIARequest -Method 'Delete' -Resource "tasks/$TaskId"
    Write-Output $response
}