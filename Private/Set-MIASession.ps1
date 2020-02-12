# Private function to set the script-level session
# variables needed for subsequent REST API calls.
# Currently this in the token and hostname, but
# could also include the refresh token.
function Set-MIASession
{
    [CmdletBinding()]
    param (
        [string]$Hostname,
        [psobject]$Response
    )

    $Script:MIASession = [PSCustomObject]@{
        Hostname = $Hostname
        Token = $Response.access_token
        CreatedAt = $(Get-Date)
        ExpiresIn = $(New-Timespan -Seconds $Response.expires_in)
        RefreshToken = $Response.refresh_token
    }

    #$Script:MIAHostname = $Hostname
    #$Script:MIAToken = $Response.access_token
}