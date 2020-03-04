function Convert-PSBoundToRequestBody
{
    [CmdletBinding()]
    param (
        # The caller will pass in the dictionary, presumably the $PSBoundParameters,
        # which will contain the parameters used to call the caller.
        [Parameter(Mandatory, Position=0)]
        [System.Collections.IDictionary]$Params,
        # Array or keys that should be excluded, typically and Id
        [string[]]$KeysToExclude
    )

    $body = @{}
    foreach ($p in $Params.GetEnumerator()) {
        # Need to exclude any switch parameters as well as any keys that should
        # be excluded
        if ($p.Value -isnot [switch] -and $p.Key -notin $KeysToExclude) {
            #Get the key for the parameter, converting the first letter to
            #lowercase to match what REST API expects.
            $key = $p.key.substring(0,1).ToLower() + $p.key.substring(1)
            #Add to the body hashtable
            $body[$key] =  $p.Value
        }
    }

    return $body
}