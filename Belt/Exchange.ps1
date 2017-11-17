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

<#
.SYNOPSIS
Connects to Exchange Online.

.DESCRIPTION
Enters a new PSSession with the Exchange Online service (Office365), prompting
for credentials.
#>
function Enter-ExchangeOnlineSession {
    try {
        $session = New-PSSession `
            -ConfigurationName Microsoft.Exchange `
            -ConnectionUri https://outlook.office365.com/powershell-liveid/ `
            -Credential $(Get-Credential) `
            -Authentication Basic `
            -AllowRedirection
        Import-PSSession $session
    } catch {
        Write-Warning $_
        Exit
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
