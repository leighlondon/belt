@{
# Script module or binary module file associated with this manifest
RootModule = 'Belt.psm1'

# Version number of this module.
ModuleVersion = '0.0.2'

# ID used to uniquely identify this module
GUID = '1fff37cd-cb4d-4ac1-9ef4-323d78b7a2ce'

# Author of this module
Author = 'Leigh London'

# Functions to export from this module
FunctionsToExport = @(
    # User
    'ConvertTo-SID',
    # Exchange
    'Enter-ExchangeOnlineSession',
    'Exit-ExchangeOnlineSessions',
    'Get-MailboxForwards',
    # Meta helpers
    'Get-FunctionSource'
)

# Private data to pass to the module specified in RootModule/ModuleToProcess
# PrivateData = ''

}