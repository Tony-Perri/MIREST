<#
    Generic method to wrap Invoke-RESTMethod for MITRequests.
#>
function Invoke-MITRequest
{
    [CmdletBinding()]
    param(
        [string]$Resource,
        [string]$Method = 'GET',
        [string]$Hostname = $Script:MITHostname,
        [string]$Token = $Script:MITToken,
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