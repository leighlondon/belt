if ($env:APPVEYOR_REPO_TAG -ne $true) {
    Write-Information "not deploying, no tag"
    return
} else {
    # deploy since it's a tagged release.
    Write-Information "deploying..."
    # load in the manifest to get the version number.
    $Manifest = Test-ModuleManifest '.\Belt.psd1'
    # calculate the module path for a windows system.
    $ModulePath = $env:PSModulePath.Split(';')[0]
    # prepare to install the module manually.
    $ZipParams = @{
        Path = '.\Belt.zip'
        DestinationPath = "$ModulePath\Belt\$($Manifest.Version)"
        Verbose = $true
    }
    Expand-Archive @ZipParams
    # load and publish
    Import-Module Belt
    Publish-Module -Name 'Belt' -NuGetApiKey $env:DeployKey -Verbose
}
