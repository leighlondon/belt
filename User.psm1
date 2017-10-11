function Get-UserSID {
    param([parameter(mandatory=$TRUE)][string]$username)
    $u = New-Object System.Security.Principal.NTAccount($username)
    return $u.Translate([System.Security.Principal.SecurityIdentifier]).Value 
}

Export-ModuleMember -function Get-UserSID
