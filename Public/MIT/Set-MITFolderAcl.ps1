function Set-MITFolderAcl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Id,
        [Parameter(Mandatory)]
        [ValidateSet('User','Group')]
        [string]$Type,
        [Parameter(Mandatory)]
        [string]$TypeId,
        [switch]$ReadFiles,
        [switch]$WriteFiles,
        [switch]$DeleteFiles,
        [switch]$ListFiles,
        [switch]$Notify,
        [switch]$AddDeleteSubfolders,
        [switch]$Share,
        [switch]$Admin,
        [switch]$ListUsers
    )

    # Need to build the body for this request.  Doesn't currently include setting share permissions.
    $body = @{
        type = "$Type"
        id = "$TypeId"
        permissions = @{
            readFiles = "$ReadFiles"
            writeFiles = "$WriteFiles"
            deleteFiles = "$DeleteFiles"
            listFiles = "$ListFiles"
            notify = "$Notify"
            addDeleteSubfolders = "$AddDeleteSubfolders"
            share = "$Share"
            admin = "$Admin"
            listUsers = "$ListUsers"
        }
    }

    $response = Invoke-MITRequest -Method 'Put' -Resource "folders/$Id/acls" -Body $body
    Write-MITOutput -Response $response -Typename 'MIREST.MITFolderAcl'
#     "type": "None",
#   "id": "string",
#   "permissions": {
#     "readFiles": true,
#     "writeFiles": true,
#     "deleteFiles": true,
#     "listFiles": true,
#     "notify": true,
#     "addDeleteSubfolders": true,
#     "share": true,
#     "sharePermissions": {
#       "readFiles": true,
#       "writeFiles": true,
#       "deleteFiles": true,
#       "listFiles": true,
#       "notify": true,
#       "listUsers": true
#     },
#     "admin": true,
#     "listUsers": true
}