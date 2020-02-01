function Add-MIRESTTypeName
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                    ValueFromPipeline)]
        [psobject[]]$Object,

        [Parameter(Mandatory)]
        [string]$TypeName

    )

    Process {
        $Object | ForEach-Object {
            $_.PSOBject.TypeNames.Insert(0,$TypeName)
            Write-Output $_
        }
    }
}