function Start-MIATask
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                    ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string]$TaskId,
        [hashtable]$Params
    )

    $response = Invoke-MIARequest -Method 'Post' -Resource "tasks/$TaskId/start" -Body $Params
    Write-Output $response
}