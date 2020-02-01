function Get-MITUser
{
    [CmdletBinding(DefaultParameterSetName='List')]
    param (
        #Detail params
        [Parameter(Mandatory,
                    ValueFromPipelineByPropertyName=$true,
                    ParameterSetName='Detail')]
        [string]$Id,

        #Self params
        [Parameter(Mandatory,
                    ParameterSetName='Self')]
        [switch]$Self,

        #List params
        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [string]$Username,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [ValidateSet("AllUsers","EndUsers","Administrators","FileAdmins","GroupAdmins","TemporaryUsers","SysAdmins" )]
        [string]$Permission,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [ValidateSet("AllUsers","ActiveUsers","InactiveUsers","NeverSignedOnUsers","TemplateUsers")]
        [string]$Status,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [string]$Realname,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [string]$FullName,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [string]$Email,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [int32]$Page,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [int32]$PerPage,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [ValidateSet('username', 'realname', 'lastLoginStamp', 'email')]
        [string]$SortField,

        [Parameter(Mandatory=$false,
                    ParameterSetName='List')]
        [ValidateSet('ascending', 'descending')]
        [string]$SortDirection
    )

    switch ($PSCmdlet.ParameterSetName)
    {
        'Detail' {
            $response = Invoke-MITRequest -Resource "users/$Id"
            Write-MITOutput -Response $response -Typename "MIREST.MITUserDetail"
        }
        'Self' {
            $response = Invoke-MITRequest -Resource "users/self"
            Write-MITOutput -Response $response -Typename "MIREST.MITUserDetail"
        }
        'List' {
            $query = BuildQueryFromPSBoundParameters($PSBoundParameters)
            $response = Invoke-MITRequest -Resource "users" -Query $query
            Write-MITOutput -Response $response -Typename "MIREST.MITUserSimple"
        }
    }

}