function Get-MIATask
{
    [CmdletBinding(DefaultParameterSetName='List')]
    param (
        [Parameter(Mandatory,
                    ValueFromPipelineByPropertyName=$true,
                    ParameterSetName='Detail')]
        [string]$Id,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [string]$Name,

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

    if ('Detail' -eq $PSCmdlet.ParameterSetName) {
        $response = Invoke-MIARequest -Resource "tasks/$Id"
        Write-MIAOutput -Response $response -Typename 'MIREST.MIATask'
    }
    else {
        $query = BuildQueryFromPSBoundParameters($PSBoundParameters)
        $response = Invoke-MIARequest -Resource "tasks" -Query $query
        Write-MIAOutput -Response $response -Typename "MIREST.MIATask"
    }


}