function Get-MIATask
{
    [CmdletBinding(DefaultParameterSetName='List')]
    param (
        [Parameter(Mandatory,
                    ValueFromPipelineByPropertyName=$true,
                    ParameterSetName='Detail')]
        [Alias('Id')]
        [string]$TaskId,

        [Parameter(Mandatory,
                    ParameterSetName='Running')]
        [switch]$Running,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [Parameter(Mandatory=$false,
                    ParameterSetName='Running')]
        [string]$Name,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [Parameter(Mandatory=$false,
                    ParameterSetName='Running')]
        [string]$Fields,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [Parameter(Mandatory=$false,
                    ParameterSetName='Running')]
        [int32]$Page,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [Parameter(Mandatory=$false,
                    ParameterSetName='Running')]
        [int32]$PerPage

    )

    switch ($PSCmdlet.ParameterSetName) {
        'Detail' {
            $response = Invoke-MIARequest -Resource "tasks/$TaskId"
            Write-MIAOutput -Response $response -Typename 'MIREST.MIATask'
        }
        'Running' {
            $query = BuildQueryFromPSBoundParameters($PSBoundParameters)
            $response = Invoke-MIARequest -Resource "tasks/running" -Query $query
            Write-MIAOutput -Response $response -Typename "MIREST.MIATaskRunning"
        }
        'List' {
            $query = BuildQueryFromPSBoundParameters($PSBoundParameters)
            $response = Invoke-MIARequest -Resource "tasks" -Query $query
            Write-MIAOutput -Response $response -Typename "MIREST.MIATask"
        }
    }


}