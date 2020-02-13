function Get-MIAPGPKey
{
    [CmdletBinding(DefaultParameterSetName='List')]
    param (
        [Parameter(Mandatory,
                    ParameterSetName='Detail')]
        [string]$PgpKeyId,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [string]$Uid,

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
            $response = Invoke-MIARequest -Resource "pgpkeys/$PgpKeyId"
            Write-MIAOutput -Response $response -Typename 'MIREST.MIAPGPKey'
        }
        'List' {
            Write-Verbose "Getting list of PGP Keys"
            $query = BuildQueryFromPSBoundParameters($PSBoundParameters)
            $response = Invoke-MIARequest -Resource "pgpkeys" -Query $query
            Write-MIAOutput -Response $response -Typename "MIREST.MIAPGPKey"
        }
    }

}