function Get-AzureUser {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [String]
        $Username
    )
    begin {
        Test-AzureADConnection
    }
    process {
        Get-AzureADUser -Filter "startswith(UserPrincipalName,$Username)"
    }
}

function Test-AzureADConnection {
    if ((Get-AzureADCurrentSessionInfo | Measure-Object).Count -lt 1) {
        Write-Warning 'Not connected to AzureAD'
        throw 'Not connected to AzureAD'
    }
}
