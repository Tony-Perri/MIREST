function Get-MIAReportTaskRun
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]$Predicate = 'Status=in=("Success","Failure")',

        [Parameter(Mandatory=$false)]
        [string]$OrderBy = '!StartTime',

        [Parameter(Mandatory=$false)]
        [int32]$MaxCount = 100

    )

    $query = @{
        predicate = "$Predicate";
        orderBy = "$OrderBy";
        maxCount = "$MaxCount"
    }

    $response = Invoke-MIARequest -Resource 'reports/taskruns' -Method 'Post' -Query $query
    Write-MIAOutput -Response $response -Typename 'MIREST.MIAReportTaskRun'
}