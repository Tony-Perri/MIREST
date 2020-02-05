function BuildQueryFromPSBoundParameters([System.Collections.IDictionary]$psbp)
{
    $query = @{}
    foreach ($p in $psbp.GetEnumerator()) {
        #Need to ignore any parameters containing 'Id' and any switch parameters
        if (($p.key -notlike '*Id*') -and ($p.Value -isnot [switch])) {
            #Get the key for the parameter, converting the first letter to
            #lowercase to match what REST API expects.
            $key = $p.key.substring(0,1).ToLower() + $p.key.substring(1)
            #Add to the query hashtable, taking into account the Value might be an array
            $query[$key] =  $p.Value
        }
    }

    return $query
}