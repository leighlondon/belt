<#
.SYNOPSIS
List the forwards active on a mailbox.

.DESCRIPTION
Returns the ForwardingAddress and ForwardingSmtpAddress for a mailbox forward.
#>
function Get-MailboxForwards {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$TRUE)]
        [String]
        $Mailbox
    )
    begin { Test-ExchangeConnection }
    process {
        Get-Mailbox -Identity $Mailbox |
            Select-Object -Property ForwardingAddress,ForwardingSmtpAddress
    }
}

function Get-MailboxRules {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$TRUE)]
        [String]
        $Mailbox
    )
    begin { Test-ExchangeConnection }
    process {
        Get-InboxRule -Mailbox $Mailbox |
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
function Connect-ExchangeOnlineSession {
    [CmdletBinding()]
    param(
        [PSCredential]
        $Credential
    )
    process {
        try {
            if ($Credential -eq $null) { $Credential = Get-Credential }
            # splat the options for the new-pssession (to make it easier to read)
            $Options = @{
                'ConfigurationName' = 'Microsoft.Exchange'
                'ConnectionUri' = 'https://outlook.office365.com/powershell-liveid/'
                'Credential' = $Credential
                'Authentication' = 'Basic'
                'AllowRedirection' = $true
                'ErrorAction' = 'Stop'
            }
            $Session = New-PSSession @Options
            Import-Module (Import-PSSession $Session -AllowClobber) -Global
        } catch  {
            Write-Warning 'Unable to connect to Exchange'
            throw $_
        }
    }
}

<#
.SYNOPSIS
Disconnects from (all) Exchange Online remote session(s).

.DESCRIPTION
Disconnects any remote PSSession(s) from the Exchange Online service (Office365).
#>
function Disconnect-ExchangeOnlineSessions {
    Get-ExchangeOnlineSessions | Remove-PSSession
}

function Get-ExchangeOnlineSessions {
    Get-PSSession |
        Where-Object { $_.ComputerName -eq 'outlook.office365.com' -and $_.ConfigurationName -eq 'Microsoft.Exchange' }
}

function Test-ExchangeConnection {
    if ((Get-ExchangeOnlineSessions | Measure-Object).Count -lt 1) {
        Write-Warning 'Not connected to Exchange'
        throw 'Not connected to Exchange'
    }
}
