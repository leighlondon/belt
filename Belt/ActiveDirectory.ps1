function Get-GroupMembers {
    param([String]$group)

    Get-ADGroupMember -Identity $group |
        Get-ADUser -Property DisplayName |
        Select-Object Name,DisplayName
}
