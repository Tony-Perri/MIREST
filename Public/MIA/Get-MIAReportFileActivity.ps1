function Get-MIAReportFileActivity
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]$Predicate = 'StatusCode=out=("5000","5010")',

        [Parameter(Mandatory=$false)]
        [string]$OrderBy = '!LogStamp',

        [Parameter(Mandatory=$false)]
        [int32]$MaxCount = 100

    )

    $query = @{
        predicate = "$Predicate";
        orderBy = "$OrderBy";
        maxCount = "$MaxCount"
    }

    $response = Invoke-MIARequest -Resource 'reports/fileactivity' -Method 'Post' -Query $query
    Write-MIAOutput -Response $response -Typename 'MIREST.MIAReportFileActivity'
}