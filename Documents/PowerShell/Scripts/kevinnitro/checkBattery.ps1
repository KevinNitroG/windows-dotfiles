function Check-Battery
{
    Set-Location
    powercfg /batteryreport
    & "$env:USERPROFILE\battery-report.html"
    Start-Sleep -Seconds 1
    Remove-Item -Path "$env:USERPROFILE\battery-report.html" -Force
}
