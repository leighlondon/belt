function Resolve-DNS {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [String]
        $Domain
    )
    process {
        try {
            Resolve-DNSName $Domain -Type ALL
        } catch [System.Management.Automation.CommandNotFoundException] {
            'Unable to find command: Resolve-DNSName' | Write-Warning
        }
    }
}
