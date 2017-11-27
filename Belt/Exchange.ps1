<#
.SYNOPSIS
List the forwards active on a mailbox.

.DESCRIPTION
Returns the ForwardingAddress and ForwardingSmtpAddress for a mailbox forward.
#>
function Get-MailboxForwards {
    [CmdletBinding()]
    param(
        [parameter(mandatory=$true)]
        [String]
        $mailbox
    )
    begin { Test-ExchangeConnection }
    process {
        Get-Mailbox -Mailbox $mailbox |
            Select-Object -Property ForwardingAddress,ForwardingSmtpAddress
    }
}

function Get-MailboxRules {
    param(
        [parameter(mandatory=$true)]
        [String]
        $mailbox
    )
    begin { Test-ExchangeConnection }
    process {
        Get-InboxRule -Mailbox $mailbox |
            Select-Object -Property Name,ForwardTo,RedirectTo
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
        Import-Module (Import-PSSession $session)
    } catch  {
        Write-Warning 'Unable to connect to Exchange'
        throw $_
    }
}

<#
.SYNOPSIS
Disconnects from (all) Exchange Online remote session(s).

.DESCRIPTION
Disconnects any remote PSSession(s) from the Exchange Online service (Office365).
#>
function Exit-ExchangeOnlineSessions {
    Get-PSSession |
        where { $_.ComputerName -eq 'outlook.office365.com' -and $_.ConfigurationName -eq 'Microsoft.Exchange' } |
        Remove-PSSession
}

function Test-ExchangeConnection {
    # test for a valid connection to exchange by looking for a cmdlet.
    $exists = [bool](Get-Command -Name Check-MailboxQuotas -ErrorAction SilentlyContinue)
    if ($exists -eq $false) {
        Write-Warning 'Not connected to Exchange'
        throw 'Not connected to Exchange'
    }
}
