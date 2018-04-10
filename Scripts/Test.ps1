$filename = ".\TestResults.xml"
$results = Invoke-Pester -Path "$PSScriptRoot\..\Tests" -OutputFormat NUnitXml -OutputFile $filename -PassThru

if ($env:APPVEYOR) {
    # upload the results if within appveyor
    $wc = New-Object 'System.Net.WebClient'
    $wc.UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path $filename))
}

if ($results.FailedCount -gt 0) { throw "$($results.FailedCount) tests failed." }
