function Get-MIATaskLog
{
    [CmdletBinding(DefaultParameterSetName='List')]
    param (
        [Parameter(Mandatory,
                    ParameterSetName='List')]
        [Parameter(Mandatory,
                    ParameterSetName='Detail')]
        [string]$TaskId,

        [Parameter(Mandatory,
                    ParameterSetName='Detail')]
        [string]$TaskLogId,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [string]$Fields,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [int32]$Page,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [int32]$PerPage

    )

    switch ($PSCmdlet.ParameterSetName) {
        'Detail' {
            $response = Invoke-MIARequest -Resource "tasks/$TaskId/log/$TaskLogId"
            #Write-MIAOutput -Response $response -Typename 'MIREST.MIATask'
            Write-Output $response
        }
        'List' {
            #Need to exclude "TaskId" from the parameters used for the query string
            $limitedParameters = $PSBoundParameters
            $limitedParameters.Remove('TaskId') | Out-Null
            $query = BuildQueryFromPSBoundParameters($limitedParameters)
            $response = Invoke-MIARequest -Resource "tasks/$TaskId/log" -Query $query
            Write-MIAOutput -Response $response -Typename "MIREST.MIATaskLog"
        }
    }


}