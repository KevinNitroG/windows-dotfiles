function Stop-Unikey
{
  if (Get-Process -Name "UniKeyNT" -ErrorAction SilentlyContinue)
  {
    Start-Process -filepath "powershell" -Argumentlist "Stop-Process -Name UniKeyNT" -Verb runas
  } else
  {
    Write-Host "UniKeyNT isn't running! No need to stop!"
  }
}

function Start-Unikey
{
  Start-Process "$($env:LOCALAPPDATA)\UniKey\UniKeyNT.exe" -Verb runas
}

function Restart-Unikey
{
  Stop-Unikey
  Start-Unikey
}
