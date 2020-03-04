function Remove-MITUser {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Id
    )

    $response = Invoke-MITRequest -Method 'Delete' -Resource "users/$Id"
    Write-Output $response
}