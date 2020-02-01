function Get-MITTransferStatus
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [int32]$RecentlyCompletedPeriod,

        [Parameter(Mandatory=$false)]
        [int32]$StatusDistributionPeriod,

        [Parameter(Mandatory=$false)]
        [string]$UserLoginName,

        [Parameter(Mandatory=$false)]
        [string]$UserRealName,

        [Parameter(Mandatory=$false)]
        [string]$UserFullName,

        [Parameter(Mandatory=$false)]
        [string]$UserIp,

        [Parameter(Mandatory=$false)]
        [string]$FolderName,

        [Parameter(Mandatory=$false)]
        [string]$FileName,

        #Note - the REST API supports an array (i.e. ?transferStatus=Failed&transferStatus=Active).
        #However, we are using a hashtable to build up the query string by passing the hasttable to
        #the invoke-restmethod -Body parameter, so, we can only supply one transferStatus query
        #parameter.
        [Parameter(Mandatory=$false)]
        [ValidateSet('Failed','Stalled','Active','Completed')]
        [string]$TransferStatus,

        [Parameter(Mandatory=$false)]
        [string]$Search,

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

    $query = BuildQueryFromPSBoundParameters($PSBoundParameters)
    $response = Invoke-MITRequest -Resource "xferstatus" -Query $query
    Write-MITOutput -Response $response -Typename "MIREST.MITTransferStatus"

}