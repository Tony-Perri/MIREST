<#
    Generic method to wrap Invoke-RESTMethod for MIARequests.
#>
function Invoke-MIARequest
{
    [CmdletBinding()]
    param(
        [string]$Resource,
        [string]$Method = 'GET',
        [string]$Hostname = $Script:MIAHostname,
        [string]$Token = $Script:MIAToken,
        [hashtable]$Query
    )


    $Uri = "https://$Hostname/api/v1/$Resource"
    $Headers = @{
            Accept = "application/json"
            Authorization = "Bearer $Token"
        }

    if ($Method -eq 'POST') {
        $Headers.Add("Content-Type", "application/json")
        $body = ConvertTo-Json $Query
    }
    else {
        $body = $Query
    }

    $response = Invoke-RestMethod -Uri $Uri -Method $Method -Headers $Headers -Body $body
    Write-Output $response
}