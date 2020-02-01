# Private function to set the script-level session
# variables needed for subsequent REST API calls.
# Currently this in the token and hostname, but
# could also include the refresh token.
function Set-MITSession
{
    [CmdletBinding()]
    param (
        [string]$Hostname,
        [string]$Token
    )

    $Script:MITHostname = $Hostname
    $Script:MITToken = $Token
}