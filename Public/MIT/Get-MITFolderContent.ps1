function Get-MITFolderContent
{
    [CmdletBinding(DefaultParameterSetName='List')]
    param (
        [Parameter(Mandatory,
                    ValueFromPipelineByPropertyName=$true,
                    ParameterSetName='List')]
        [string]$Id,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [string]$Name,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [int32]$Page,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [int32]$PerPage,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [ValidateSet('name', 'type', 'path')]
        [string]$SortField,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [ValidateSet('ascending', 'descending')]
        [string]$SortDirection
    )

    switch ($PSCmdlet.ParameterSetName)
    {
        'List' {
            #Need to exclude "Id" from the parameters used for the query string
            $limitedParameters = $PSBoundParameters
            $limitedParameters.Remove('Id') | Out-Null
            $query = BuildQueryFromPSBoundParameters($limitedParameters)
            $response = Invoke-MITRequest -Resource "folders/$Id/content" -Query $query
            Write-MITOutput -Response $response -Typename 'MIREST.MITFolderContent'
        }
    }

}