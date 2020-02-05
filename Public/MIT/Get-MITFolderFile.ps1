function Get-MITFolderFile
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
        [ValidateSet('name', 'size', 'datetime', 'uploadstamp', 'path')]
        [string]$SortField,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [ValidateSet('ascending', 'descending')]
        [string]$SortDirection,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [ValidateSet('true', 'false')]
        [string]$NewOnly
    )

    switch ($PSCmdlet.ParameterSetName)
    {
        'List' {
            $query = BuildQueryFromPSBoundParameters($PSBoundParameters)
            $response= Invoke-MITRequest -Resource "folders/$Id/files" -Query $query
            Write-MITOutput -Response $response -Typename 'MIREST.MITFileSimple'
        }
    }
}