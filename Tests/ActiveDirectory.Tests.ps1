Import-Module $PSScriptRoot\..\Belt.psd1

InModuleScope Belt {
    Describe "Get-Computer" {
        It "calls the right cmdlet" {
            function Get-ADComputer {}
            Mock -CommandName Get-ADComputer -MockWith {}
            Get-Computer "test"
            Assert-MockCalled Get-ADComputer -Times 1
        }
    }

    Describe "Get-User" {
        It "calls the right cmdlet" {
            function Get-ADUser {}
            Mock -CommandName Get-ADUser -MockWith {}
            Assert-MockCalled Get-ADUser -Times 0
            Get-User "leigh"
            Assert-MockCalled Get-ADUser -Times 1
        }
    }
}
