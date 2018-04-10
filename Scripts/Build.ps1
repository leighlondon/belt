$ZipParameters = @{
    Path = 'Belt*', 'LICENSE', 'README.md'
    DestinationPath = '.\Belt.zip'
    Update = $true
    Verbose = $true
}
Compress-Archive @ZipParameters
# push the artifact when running on appveyor
if ($env:APPVEYOR) { Push-AppveyorArtifact '.\Belt.zip' }
