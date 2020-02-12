function RefreshMIASessionIfNeeded
{
    $elapsed = New-TimeSpan -Start $Script:MIASession.CreatedAt
    Write-Host "Session at $($elapsed) of $($Script:MIASession.ExpiresIn)"

    if ($elapsed -gt $Script:MIASession.ExpiresIn) {

        Write-Host "Session expired, refreshing..."

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
