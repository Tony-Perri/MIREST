function Remove-MITFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Id
    )

    $response = Invoke-MITRequest -Method 'Delete' -Resource "folders/$Id"
    Write-Output $response
}