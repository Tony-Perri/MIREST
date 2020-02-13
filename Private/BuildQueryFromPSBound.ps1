function BuildQueryFromPSBoundParameters([System.Collections.IDictionary]$psbp)
{
    $query = @{}
    foreach ($p in $psbp.GetEnumerator()) {
        #Need to ignore any switch parameters
        if ($p.Value -isnot [switch]) {
            #Get the key for the parameter, converting the first letter to
            #lowercase to match what REST API expects.
            $key = $p.key.substring(0,1).ToLower() + $p.key.substring(1)
            #Add to the query hashtable
            $query[$key] =  $p.Value
        }
    }

    return $query
}