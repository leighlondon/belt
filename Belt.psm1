# Load all of the scripts under .\Belt\ manually.
Get-ChildItem -Path $PSScriptRoot\Belt\*.ps1 | foreach { . $_.FullName }
