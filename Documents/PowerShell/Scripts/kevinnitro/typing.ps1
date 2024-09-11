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

function Stop-EVKey
{
  if (Get-Process -Name "EVKey64" -ErrorAction SilentlyContinue)
  {
    Start-Process -filepath "powershell" -Argumentlist "Stop-Process -Name EVKey64" -Verb runas
  } else
  {
    Write-Host "EVKey64 isn't running! No need to stop!"
  }
}

function Start-EVKey
{
  Start-Process "$($env:LOCALAPPDATA)\EVKey\EVKey64.exe" -Verb runas
}

function Restart-EVKey
{
  Stop-EVKey
  Start-EVKey
}
