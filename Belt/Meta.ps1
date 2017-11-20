<#
.SYNOPSIS
Gets the source scriptblock for a function.

.DESCRIPTION
This is a helper to show you the source (main script block) of a given function.
#>
function Get-Source {
    param($f)
    try {
        (Get-ChildItem -ErrorAction Stop function:$f).Definition
    } catch [System.Management.Automation.ActionPreferenceStopException] {
        Write-Warning 'Function not found'
    }
}
