<#
.SYNOPSIS
Gets the source scriptblock for a function.

.DESCRIPTION
This is a helper to show you the source (main script block) of a given function.
#>
function Get-FunctionSource {
    [CmdletBinding()]
    param(
        [String]
        $Func
    )
    try {
        (Get-ChildItem function:$Func -ErrorAction Stop).Definition
    } catch [System.Management.Automation.ActionPreferenceStopException] {
        'Function not found: ' + $Func | Write-Warning
    }
}

function ConvertFrom-FileTime {
    param(
        [Long]
        $Time
    )
    [DateTime]::FromFileTime($Time)
}
