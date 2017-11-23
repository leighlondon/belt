<#
.SYNOPSIS
Gets a list of group members.

.DESCRIPTION
Gets the "Name" and "DisplayName" properties for all members in a given
Active Directory group.
#>
function Get-GroupMembers {
    param([String]$group)
    try {
        Get-ADGroupMember -Identity $group |
            Get-ADUser -Property DisplayName |
            Select-Object Name,DisplayName
    } catch {
        'Group not found: ' + $group | Write-Warning
        throw $_
    }
}
