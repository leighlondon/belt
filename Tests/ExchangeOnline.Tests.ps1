Import-Module $PSScriptRoot\..\Belt.psd1

InModuleScope Belt {
    Describe "ExchangeOnline" {
        Context "Test-ExchangeOnlineConnection" {
            It "throws when not connected" {
                { Test-ExchangeOnlineConnection } | Should Throw
            }
        }
    }
}
