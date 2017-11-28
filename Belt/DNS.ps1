function Resolve-DNS {
    param([String]$domain)
    try {
        Resolve-DNSName $domain -Type ALL
    } catch [System.Management.Automation.CommandNotFoundException] {
        'Unable to find command: ' + 'Resolve-DNSName' | Write-Warning
    }
}
