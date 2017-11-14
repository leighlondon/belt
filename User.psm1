function Get-UserSID {
    [CmdletBinding()]
    param([parameter(mandatory=$TRUE)][string]$username)
    process {
        $u = New-Object System.Security.Principal.NTAccount($username)
        $u.Translate([System.Security.Principal.SecurityIdentifier]).Value | Write-Output
    }
}

Export-ModuleMember -function Get-UserSID
