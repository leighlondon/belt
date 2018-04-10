if ($env:APPVEYOR_REPO_TAG -ne $true) {
    Write-Host "not deploying, no tag"
    return
} else {
    # deploy since it's a tagged release.
    $ZipParams = @{
        Path = '.\Belt.zip'
        DestinationPath = "${$env:USERPROFILE}\Documents\WindowsPowerShell\Modules\Belt"
    }
    Expand-Archive @ZipParams
    Import-Module Belt
    Publish-Module -Name 'Belt' -NuGetApiKey $env:DeployKey -Verbose
}
