function Get-MIAHost
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
        [ValidateSet('FileSystem', 'FTP', 'POP3', 'Share',
                        'siLock', 'SMTP', 'SSHFTP', 'AS1', 'AS2', 'AS3','S3')]
        [string]$Type,

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
        $response = Invoke-MIARequest -Resource "hosts/$Id"
        Write-MIAOutput -Response $response -Typename 'MIREST.MIAHost'
    }
    else {
        $query = BuildQueryFromPSBoundParameters($PSBoundParameters)
        $response = Invoke-MIARequest -Resource "hosts" -Query $query

        # The JSON returned is a bit unique when parsed into a PSObject
        # in that the "Type" becomes a property and then the actual object
        # is nested under that, so we'll modify the $response.items so that
        # it directly contains the host members, similar to all other
        # responses.

        # A list of the possible host types to make sure we access the
        # correct properties
        $hostTypes = @('FileSystem', 'FTP', 'POP3', 'Share',
                        'siLock', 'SMTP', 'SSHFTP', 'AS1', 'AS2', 'AS3','S3')

        # # Doing this as an array so we can directly modify the items array
        for($i=0; $i -lt $response.items.count; $i++) {
            # The NoteProperty value should be the actual host "object"
            # we want which is also the type.
            $propName = (Get-Member -InputObject $response.items[$i] -MemberType NoteProperty).Name

            # Lets make sure it is one of our host types, just in case
            if ($propName -in $hostTypes) {
                $hostObj = $response.items[$i].$propName
                #Add the name as a Type property to the host object
                Add-Member -InputObject $hostObj -MemberType NoteProperty -Name Type -Value $propName
                # Set the items element in the array directly to the hostObj
                $response.items[$i] = $hostObj
            }
        }
        Write-MIAOutput -Response $response -Typename "MIREST.MIAHost"

    }


}