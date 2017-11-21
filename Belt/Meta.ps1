<#
.SYNOPSIS
Gets the source scriptblock for a function.

.DESCRIPTION
This is a helper to show you the source (main script block) of a given function.
#>
function Get-FunctionSource {
    param([string]$func)
    try {
        (Get-ChildItem function:$func -ErrorAction Stop).Definition
    } catch [System.Management.Automation.ActionPreferenceStopException] {
        'Function not found: ' + $func | Write-Warning
    }
}
