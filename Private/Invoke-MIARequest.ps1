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

    $params = @{
        Uri = "https://$Hostname/api/v1/$Resource"
        Method = "$Method"
        Headers = @{
            Accept = "application/json"
            Authorization = "Bearer $Token"
        }
    }

    $response = Invoke-RestMethod @params -Body $Query
    Write-Output $response
}