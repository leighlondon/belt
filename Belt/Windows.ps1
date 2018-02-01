<#
.SYNOPSIS
Convert a username to an SID.

.DESCRIPTION
Convert an input username into a full length SID, both on a domain and locally.
#>
function ConvertTo-SID {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$TRUE)]
        [String]
        $Username
    )
    process {
        try {
            $User = New-Object System.Security.Principal.NTAccount($Username)
            $SID = $User.Translate([System.Security.Principal.SecurityIdentifier])
            $SID.Value
        }
        catch {
            Write-Warning $_
        }
    }
}

<#
.SYNOPSIS
Removes all "network" printers.

.DESCRIPTION
Removes any and all printer mappings for the current user that are not "local".
#>
function Remove-NetworkPrinters {
    [CmdletBinding(SupportsShouldProcess=$True)]
    param(
        [Parameter()]
        [String]
        $Except
    )
    if ($PSCmdlet.ShouldProcess("Removing printers except $Except")) {
        Get-Printer |
            Where-Object { $_.Type -ne "Local" -and $_.Name -notlike "*$Except*" } |
            Remove-Printer
    }
}
