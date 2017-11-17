<#
.SYNOPSIS
List the forwards active on a mailbox.

.DESCRIPTION
Returns the ForwardingAddress and ForwardingSmtpAddress for a mailbox forward.
#>
function Get-MailboxForwards {
    [CmdletBinding()]
    param(
        [parameter(mandatory=$TRUE)]
        [String]
        $mailbox
    )
    begin { Test-ExchangeConnection }
    process {
        Get-Mailbox -Mailbox $mailbox | Select-Object -Property ForwardingAddress,ForwardingSmtpAddress
    }
}

function Test-ExchangeConnection {
    # test for a valid connection to exchange by looking for a cmdlet.
    $exists = [bool](Get-Command -Name Check-MailboxQuotas -ErrorAction SilentlyContinue)
    if ($exists -eq $FALSE) {
        Write-Warning "Not connected to Exchange"
        # TODO: better error handling
        Exit
    }
}
