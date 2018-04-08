Import-Module $PSScriptRoot\..\Belt.psd1

InModuleScope Belt {
    Describe "AzureActiveDirectory" {
        Context "Test-AzureADConnection" {
            It "throws when not connected" {
                { Test-AzureADConnection } | Should Throw
            }
        }
    }
}
