function Write-MITOutput
{
    [CmdletBinding()]
    param (
        #Response from Invoke-RESTMethod.  Might include paging information
        [psobject]$Response,
        #Typename to change output objects to for formatting
        [string]$Typename
    )

    #Determine if the response contains paging information and, if so, if it should be display.
    if (($Response.psobject.properties['paging']) -and ($Response.paging.totalPages -gt 1)) {
        Write-Host -NoNewLine -ForegroundColor Green "Total items: $($Response.paging.totalItems)  "
        Write-Host -NoNewLine -ForegroundColor Green "Items per page: $($Response.paging.perPage)  "
        Write-Host -ForeGroundColor Green "Displaying Page: $($Response.paging.page) of $($Response.paging.totalPages)"
        $results = $Response.items
    }
    elseif ($Response.psobject.properties['items']) {
        $results = $Response.items
    }
    else {
        $results = $Response
    }

    foreach ($r in $results) {
        $r.PSOBject.TypeNames.Insert(0,$TypeName)
    }

    Write-Output $results
}