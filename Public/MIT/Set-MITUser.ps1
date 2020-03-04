function Set-MITUser
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Id,
        [ValidateSet('MOVEitOnly', 'ExternalOnly', 'Both')]
        [string]$AuthMethod,
        [int64]$DefaultFolderId,
        [string]$Email,
        [ValidateSet('HTML','Text')]
        [string]$EmailFormat,
        [bool]$ForceChangePassword,
        [string]$Language,
        [string]$Notes,
        [ValidateSet('ReceivesNoNotifications', 'ReceivesNotifications','AdminReceivesNotifications')]
        [string]$ReceivesNotification,
        [ValidateNotNullOrEmpty()]
        [string]$Password,
        [ValidateSet('TemporaryUser', 'User', 'FileAdmin', 'Admin', 'SysAdmin')]
        [string]$Permission,
        [int64]$FolderQuota,
        [string]$FullName,
        [ValidateSet('Active','Suspended','Template')]
        [string]$Status,
        [string]$StatusNote
    )

    #Need to exclude "Id" from the parameters used for the body
    $limitedParameters = $PSBoundParameters
    $limitedParameters.Remove('Id') | Out-Null
    $body = BuildQueryFromPSBoundParameters($limitedParameters)
    $response = Invoke-MITRequest -Method 'Patch' -Resource "users/$Id" -Body $body
    Write-MITOutput -Response $response -Typename "MIREST.MITUserSimple"
}