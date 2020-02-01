function Invoke-MITRequest-Old
{
    param(
        [string]$Resource,
        [string]$Hostname = $Script:MITHostname,
        [string]$Token = $Script:MITToken,
        [hashtable]$Query = @{}
    )

    $params = @{
        Uri = "https://$Hostname/api/v1/$Resource"
        Method = 'GET'
        Headers = @{
            Accept = "application/json"
            Authorization = "Bearer $Token"
        }
    }

    $results = @()
    #$query += @{}
    $isPaging = $false
    $totalPages = 0
    do
    {
        $response = Invoke-RestMethod @params -Body $Query
        $isPaging = [bool]($response.paging)
        if ($isPaging) {
            # Save off this page of results
            $results += $response.items
            # Prepare to query the next page of results
            $totalPages = $response.paging.totalPages
            $query["page"] = $response.paging.page + 1
        }
        else {
            # Response is the entire result
            $results = $response
        }
    } while ( $isPaging -and $query["page"] -le $totalPages)

    Write-Output $results
}