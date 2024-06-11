function Start-GPG
{
  gpg-connect-agent reloadagent /bye
}

function Stop-GPG
{
  Stop-Process -Name "gpg-agent" -ErrorAction SilentlyContinue
}

function Restart-GPG
{
  Start-GPG
}
