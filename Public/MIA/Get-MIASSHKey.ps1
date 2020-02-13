function Get-MIASSHKey
{
    [CmdletBinding(DefaultParameterSetName='List')]
    param (
        [Parameter(Mandatory,
                    ParameterSetName='Detail')]
        [string]$SSHKeyId,

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

    switch ($PSCmdlet.ParameterSetName) {
        'Detail' {
            $response = Invoke-MIARequest -Resource "sshkeys/$SSHKeyId"
            Write-MIAOutput -Response $response -Typename 'MIREST.MIASSHKey'
        }
        'List' {
            Write-Verbose "Getting list of SSH Keys"
            $query = BuildQueryFromPSBoundParameters($PSBoundParameters)
            $response = Invoke-MIARequest -Resource "sshkeys" -Query $query
            Write-MIAOutput -Response $response -Typename "MIREST.MIASSHKey"
        }
    }

}