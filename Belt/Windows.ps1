<#
.SYNOPSIS
Convert a username to an SID.

.DESCRIPTION
Convert an input username into a full length SID, both on a domain and locally.
#>
function ConvertTo-SID {
    [CmdletBinding()]
    param(
        [parameter(mandatory=$TRUE)]
        [String]
        $username
    )
    process {
        try {
            $u = New-Object System.Security.Principal.NTAccount($username)
            $sid = $u.Translate([System.Security.Principal.SecurityIdentifier])
            $sid.Value
        }
        catch {
            Write-Warning $_
        }
    }
}
