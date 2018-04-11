if ($env:APPVEYOR_REPO_TAG -ne $true) {
    Write-Information "not deploying, no tag"
    return
} else {
    $Manifest = Test-ModuleManifest '.\Belt.psd1'
    $Version = $Manifest.Version
    $ModulePath = $env:PSModulePath.Split(';')[0]
    # deploy since it's a tagged release.
    $ZipParams = @{
        Path = '.\Belt.zip'
        DestinationPath = "$ModulePath\Belt\$Version"
        Verbose = $true
    }
    Expand-Archive @ZipParams
    Import-Module Belt
    Publish-Module -Name 'Belt' -NuGetApiKey $env:DeployKey -Verbose
}
