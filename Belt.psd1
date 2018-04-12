@{
# Script module or binary module file associated with this manifest
RootModule = 'Belt.psm1'

Description = 'A belt for handy tools.'

# Version number of this module.
ModuleVersion = '0.5.4'

# Minimum PowerShell version.
PowerShellVersion = '5.0'

# ID used to uniquely identify this module
GUID = '1fff37cd-cb4d-4ac1-9ef4-323d78b7a2ce'

# Author of this module
Author = 'Leigh London'

# Functions to export from this module
FunctionsToExport = @(
    # Active Directory
    'Get-Computer',
    'Get-GroupMember',
    'Get-MailboxType',
    'Get-User',
    'Get-UserFromEmail',
    'Resolve-MailboxType',
    # Azure AD
    'Get-AzureUser',
    # DNS
    'Resolve-DNS',
    # Exchange
    'Connect-ExchangeOnlineSession',
    'Disconnect-ExchangeOnlineSession',
    'Get-MailboxForward',
    'Get-MicrosoftTeamDetail',
    'Get-MicrosoftTeamOwner',
    # Helpers, or code touching more than one module.
    'Get-SpamVerificationDetails',
    # Windows
    'ConvertTo-SID',
    'Remove-NetworkPrinters',
    # Meta helpers
    'ConvertFrom-FileTime',
    'Get-FunctionSource'
)

# Private data to pass to the module specified in RootModule/ModuleToProcess
# PrivateData = ''

}
