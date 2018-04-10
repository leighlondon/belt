if ($env:APPVEYOR_REPO_TAG -ne $true) {
    Write-Host "not deploying, no tag"
    return
} else if ($env:APPVEYOR_REPO_TAG) {
    # deploy since it's a tagged release.
    Publish-Module -Name Belt -NuGetApiKey $env:NuGetApiKey
}
