<#
    Generic method to wrap Invoke-RESTMethod for MITRequests.
#>
function Invoke-MITRequest
{
    [CmdletBinding()]
    param(
        [string]$Resource,
        [string]$Method = 'GET',
        [hashtable]$Query,
        [psobject]$Body
    )

    #RefreshMITSessionIfNeeded

    $hostname = $Script:MITHostname
    $token = $Script:MITToken

    $Uri = "https://$hostname/api/v1/$Resource"
    $Headers = @{
            Accept = "application/json"
            Authorization = "Bearer $token"
        }

    if ($Method -in 'POST', 'PUT', 'PATCH') {
        $Headers.Add("Content-Type", "application/json")
        $body = ConvertTo-Json -Depth 10 $Body
    }
    else {
        $body = $Query
    }

    $response = Invoke-RestMethod -Uri $Uri -Method $Method -Headers $Headers -Body $body
    Write-Output $response
}