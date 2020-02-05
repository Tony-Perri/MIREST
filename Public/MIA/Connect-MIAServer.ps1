# Connect to a MIAServer.
function Connect-MIAServer
{
    param (
        [string]$Hostname,
        [string]$Username,
        [string]$Password
    )

    $params = @{
        Uri = "https://$Hostname/api/v1/token"
        Method = 'POST'
        ContentType = 'application/x-www-form-urlencoded'
        Body = "grant_type=password&username=$Username&password=$Password"
        Headers = @{Accept = "application/json"}
    }

    $response = Invoke-RestMethod @params
    Set-MIASession -Hostname $Hostname -Token $response.access_token
}