<#
.SYNOPSIS
Resolve the numeric mailbox type to a string.

.DESCRIPTION
Returns a human-readable string translation of the exchRemoteRecipientType attribute.
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
        # bitwise operations to decode the type.
        where { $mbox -band $_ } |
        # swallow the return value
        foreach { $_ = $result.Add($types.Get_Item($_)) }
    # returns a human-readable single string
    $result -Join ', '
}
