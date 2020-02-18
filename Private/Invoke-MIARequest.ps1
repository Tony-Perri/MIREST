<#
    Generic method to wrap Invoke-RESTMethod for MIARequests.
#>
function Invoke-MIARequest
{
    [CmdletBinding()]
    param(
        [string]$Resource,
        [string]$Method = 'GET',
        [hashtable]$Query,
        [psobject]$Body
    )

    RefreshMIASessionIfNeeded

    $hostname = $Script:MIASession.Hostname
    $token = $Script:MIASession.Token

    $Uri = "https://$hostname/api/v1/$Resource"
    $Headers = @{
            Accept = "application/json"
            Authorization = "Bearer $token"
        }

    if ($Method -in 'POST', 'PUT') {
        $Headers.Add("Content-Type", "application/json")
        $body = ConvertTo-Json -Depth 10 $Body
    }
    else {
        $body = $Query
    }

    $response = Invoke-RestMethod -Uri $Uri -Method $Method -Headers $Headers -Body $body
    Write-Output $response
}