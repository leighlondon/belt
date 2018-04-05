<#
.SYNOPSIS
Extract data about active forwarding for a mailbox, and the last time the password was changed.

.DESCRIPTION
Collates together two sources of data, Active Directory and Exchange Online,
to gather information about the currently active forwards for an Exchange mailbox
and the last time that the password was set on the related Active Directory account.
#>
function Get-SpamVerificationDetails {
    param(
        [String]
        $Email
    )
    begin {
        $PasswordColumn = @{
            'Name' = 'PasswordLastSet'
            'Expression' = {
                Get-UserFromEmail $_.Mailbox |
                    Select-Object pwdlastset |
                    ForEach-Object { ConvertFrom-FileTime $_.pwdlastset }
            }
        }
    }
    process {
        Get-MailboxForward -Mailbox $Email |
            Select-Object *, $PasswordColumn
    }
}
