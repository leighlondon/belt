@{
# Script module or binary module file associated with this manifest
RootModule = 'Belt.psm1'

Description = 'A belt for handy tools.'

# Version number of this module.
ModuleVersion = '0.2.5'

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
    'Get-GroupMembers',
    'Get-MailboxType',
    'Resolve-MailboxType',
    # DNS
    'Resolve-DNS',
    # Exchange
    'Connect-ExchangeOnlineSession',
    'Disconnect-ExchangeOnlineSessions',
    'Get-MailboxForwards',
    # Windows
    'ConvertTo-SID',
    'Remove-NetworkPrinters',
    # Meta helpers
    'Get-FunctionSource',
    'Publish-BeltModule'
)

# Private data to pass to the module specified in RootModule/ModuleToProcess
# PrivateData = ''

}
