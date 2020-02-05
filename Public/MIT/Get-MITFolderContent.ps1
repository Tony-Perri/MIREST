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
            $query = BuildQueryFromPSBoundParameters($PSBoundParameters)
            $response = Invoke-MITRequest -Resource "folders/$Id/content" -Query $query
            Write-MITOutput -Response $response -Typename 'MIREST.MITFolderContent'
        }
    }

}