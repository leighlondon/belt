<#
.SYNOPSIS
Gets a computer object.

.DESCRIPTION
Gets a computer object with the matching hostname from Active Directory.
#>
function Get-Computer {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [String]
        $Computer
    )
    process {
        try {
            Get-ADComputer -Filter "Name -like '*$Computer*'" -Properties CanonicalName |
                Select-Object Name,Enabled,CanonicalName
        } catch {
            'Computer not found: ' + $Computer | Write-Warning
            throw $_
        }
    }
}

<#
.SYNOPSIS
Gets a list of group members.

.DESCRIPTION
Gets the "Name" and "DisplayName" properties for all members in a given
Active Directory group.
#>
function Get-GroupMembers {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [String]
        $Group
    )
    process {
        $GroupColumn = @{
            'Name' = 'Group'
            'Expression' = { $Group }
        }
        try {
            Get-ADGroupMember -Identity $Group -Recursive |
                Get-ADUser -Property DisplayName |
                Select-Object $GroupColumn,Name,DisplayName
        } catch {
            'Group not found: ' + $Group | Write-Warning
            throw $_
        }
    }
}

<#
.SYNOPSIS
Get the mailbox type from a User.

.DESCRIPTION
Checks the Active Directory attributes for a given user and translates the
mailbox type into a human-readable form.
#>
function Get-MailboxType {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [String]
        $Username
    )
    begin {
        $MailboxType = @{
            'Name' = 'Mailbox Type'
            'Expression' = { Resolve-MailboxType $_.msExchRemoteRecipientType }
        }
    }
    process {
        try {
            Get-ADUser $Username -Properties msExchRemoteRecipientType |
                Select-Object Name, $MailboxType
        } catch [System.Management.Automation.CommandNotFoundException] {
            'Missing ActiveDirectory module' | Write-Warning
        } catch {
            'Not found: ' + $Username | Write-Warning
        }
    }
}

<#
.SYNOPSIS
Resolve the numeric mailbox type to a string.

.DESCRIPTION
Returns a human-readable string translation of the msExchRemoteRecipientType prop.
#>
function Resolve-MailboxType {
    param(
        [Parameter(ValueFromPipeline)]
        [Int]
        $Mailbox
    )
    begin {
        $MailboxTypes = @{
             1='ProvisionedCloudMailbox'
             2='ProvisionedCloudArchive'
             4='MigratedMailbox'
             8='DeprovisionedMailbox'
            16='DeprovisionedArchive'
            32='RoomMailbox'
            64='EquipmentMailbox'
            96='SharedMailbox'
        }
    }
    process {
        # use a dynamic type as temporary storage
        $Result = [System.Collections.ArrayList]@()
        $MailboxTypes.Keys |
            # bitwise operations to decode the type
            where { $Mailbox -bAnd $_ } |
            # swallow the return value
            foreach { $_ = $Result.Add($MailboxTypes.Get_Item($_)) }
        # returns a human-readable single string
        $Result -Join ', '
    }
}
