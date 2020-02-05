function Get-MIAReport
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                    ParameterSetName='TaskRun')]
        [switch]$TaskRun,

        [Parameter(Mandatory,
                    ParameterSetName='FileActivity')]
        [switch]$FileActivity,

        [Parameter(Mandatory,
                    ParameterSetName='Audit')]
        [switch]$Audit,

        [Parameter(Mandatory=$false)]
        [string]$Predicate = '',

        [Parameter(Mandatory=$false)]
        [string]$OrderBy = '',

        [Parameter(Mandatory=$false)]
        [int32]$MaxCount = 100

    )

    switch ($PSCmdlet.ParameterSetName)
    {
        'TaskRun' {
            if ('' -eq $Predicate) {
                $Predicate = 'Status=in=("Success","Failure")'
            }

            if ('' -eq $OrderBy) {
                $OrderBy = '!StartTime'
            }

            $query = @{
                predicate = "$Predicate";
                orderBy = "$OrderBy";
                maxCount = "$MaxCount"
            }

            $response = Invoke-MIARequest -Resource 'reports/taskruns' -Method 'Post' -Query $query
            Write-MIAOutput -Response $response -Typename 'MIREST.MIAReportTaskRun'
        }

        'FileActivity' {
            if ('' -eq $Predicate) {
                $Predicate = 'StatusCode=out=("5000","5010")'
            }

            if ('' -eq $OrderBy) {
                $OrderBy = '!LogStamp'
            }

            $query = @{
                predicate = "$Predicate";
                orderBy = "$OrderBy";
                maxCount = "$MaxCount"
            }

            $response = Invoke-MIARequest -Resource 'reports/fileactivity' -Method 'Post' -Query $query
            Write-MIAOutput -Response $response -Typename 'MIREST.MIAReportFileActivity'
        }

        'Audit' {
            if ('' -eq $Predicate) {
                $Predicate = 'Status=="Failure"'
            }

            if ('' -eq $OrderBy) {
                $OrderBy = '!LogTime'
            }

            $query = @{
                predicate = "$Predicate";
                orderBy = "$OrderBy";
                maxCount = "$MaxCount"
            }

            $response = Invoke-MIARequest -Resource 'reports/audit' -Method 'Post' -Query $query
            Write-MIAOutput -Response $response -Typename 'MIREST.MIAReportAudit'
        }
    }

}