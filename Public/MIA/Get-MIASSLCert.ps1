function Get-MIASSLCert
{
    [CmdletBinding(DefaultParameterSetName='List')]
    param (
        [Parameter(Mandatory,
                    ParameterSetName='Detail')]
        [string]$SSLCertificateThumbprint,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [string]$Issuer,

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
            $response = Invoke-MIARequest -Resource "sslcerts/$SSLCertificateThumbprint"
            Write-MIAOutput -Response $response -Typename 'MIREST.MIASSLCert'
        }
        'List' {
            Write-Verbose "Getting list of SSL Certs"
            $query = BuildQueryFromPSBoundParameters($PSBoundParameters)
            $response = Invoke-MIARequest -Resource "sslcerts" -Query $query
            Write-MIAOutput -Response $response -Typename "MIREST.MIASSLCert"
        }
    }

}