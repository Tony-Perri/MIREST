function RefreshMIASessionIfNeeded
{
    $elapsed = New-TimeSpan -Start $Script:MIASession.CreatedAt
    Write-Verbose "MIA Session at $($elapsed.TotalSeconds) of $($Script:MIASession.ExpiresIn)"

    # If the key is within 30 seconds of expiring, let's go ahead and
    # refresh it.
    if ($elapsed.TotalSeconds -gt $Script:MIASession.ExpiresIn - 30) {

        Write-Verbose "Session expired, refreshing..."

        $params = @{
            Uri = "https://$($Script:MIASession.Hostname)/api/v1/token"
            Method = 'POST'
            ContentType = 'application/x-www-form-urlencoded'
            Body = "grant_type=refresh_token&refresh_token=$($Script:MIASession.RefreshToken)"
            Headers = @{Accept = "application/json"}
        }

        $response = Invoke-RestMethod @params
        Set-MIASession -Hostname $Script:MIASession.Hostname -Response $response
    }
}
