function Write-MIAOutput
{
    [CmdletBinding()]
    param (
        #Response from Invoke-RESTMethod.  Might include paging information
        [psobject]$Response,
        #Typename to change output objects to for formatting
        [string]$Typename
    )


    if (($Response.psobject.properties['paging']) -and ($Response.paging.perPage -lt [Int32]::MaxValue)) {
        Write-Host "Total items: $($Response.paging.totalItems)"
        Write-Host "Items per page: $($Response.paging.perPage)"
        Write-Host "Displaying Page: $($Response.paging.page) of $($Response.paging.totalPages)"
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