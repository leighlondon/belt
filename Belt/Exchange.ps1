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
        $credential = Get-Credential
        # splat the options for the new-pssession (to make it easier to read)
        $options = @{
            'ConfigurationName' = 'Microsoft.Exchange'
            'ConnectionUri' = 'https://outlook.office365.com/powershell-liveid/'
            'Credential' = $credential
            'Authentication' = 'Basic'
            'AllowRedirection' = $true
            'ErrorAction' = 'Stop'
        }
        $session = New-PSSession @options
        Import-PSSession $session
    } catch  {
        Write-Warning "Unable to connect to Exchange"
        throw $_
    }
}

<#
.SYNOPSIS
Disconnects from a Exchange Online remote session.

.DESCRIPTION
Disconnects a remote PSSession from the Exchange Online service (Office365).
#>
function Exit-ExchangeOnlineSession {
    Get-PSSession |
    Where {
        $_.ComputerName -eq "outlook.office365.com" -and $_.ConfigurationName -eq "Microsoft.Exchange"
    } |
    Remove-PSSession
}

function Test-ExchangeConnection {
    # test for a valid connection to exchange by looking for a cmdlet.
    $exists = [bool](Get-Command -Name Check-MailboxQuotas -ErrorAction SilentlyContinue)
    if ($exists -eq $FALSE) {
        Write-Warning "Not connected to Exchange"
        # TODO: better error handling
        throw "Not connected to Exchange"
    }
}
