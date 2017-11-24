<#
.SYNOPSIS
Gets a computer object.

.DESCRIPTION
Gets a computer object with the matching hostname from Active Directory.
#>
function Get-Computer {
    param([String]$computer)
    Get-ADComputer -Filter "Name -like '*$computer*'" |
        Select-Object Name,Enabled,DNSHostName,DistinguishedName
}

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
        Get-ADGroupMember -Identity $group -Recursive |
            Get-ADUser -Property DisplayName |
            Select-Object Name,DisplayName
    } catch {
        'Group not found: ' + $group | Write-Warning
        throw $_
    }
}

function Get-MailboxType {
    param([string]$username)
    $type = @{
        'Name' = 'Mailbox Type'
        'Expression' = { Resolve-MailboxType $_.msExchRemoteRecipientType }
    }
    try {
        Get-ADUser $username -Properties msExchRemoteRecipientType |
            Select-Object Name, $type
    } catch {
        'Not found: ' + $username | Write-Warning
    }
}

<#
.SYNOPSIS
Resolve the numeric mailbox type to a string.

.DESCRIPTION
Returns a human-readable string translation of the msExchRemoteRecipientType prop.
#>
function Resolve-MailboxType {
    param([Int64]$mbox)
    $types = @{
        1='ProvisionedCloudMailbox'
        2='ProvisionedCloudArchive'
        4='MigratedMailbox'
        8='DeprovisionedMailbox'
        16='DeprovisionedArchive'
        32='RoomMailbox'
        64='EquipmentMailbox'
        96='SharedMailbox'
    }
    # use a dynamic type as temporary storage
    $result = [System.Collections.ArrayList]@()
    $types.Keys |
        # bitwise operations to decode the type
        where { $mbox -band $_ } |
        # swallow the return value
        foreach { $_ = $result.Add($types.Get_Item($_)) }
    # returns a human-readable single string
    $result -Join ', '
}
