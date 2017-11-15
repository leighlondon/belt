function ConvertTo-SID {
    [CmdletBinding()]
    param(
        [parameter(mandatory=$TRUE)]
        [String]
        $username
    )
    process {
        try {
            $u = New-Object System.Security.Principal.NTAccount($username)
            $sid = $u.Translate([System.Security.Principal.SecurityIdentifier])
            $sid.Value
        }
        catch {
            Write-Warning $_
        }
    }
}

function Fake-FunctionToTest {
    [CmdletBinding()]
    param([string]$t)
    process {$t}
}
