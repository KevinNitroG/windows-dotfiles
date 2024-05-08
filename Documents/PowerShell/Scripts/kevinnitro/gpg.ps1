function Start-GPG
{
  if (!(Get-Process "gpg-agent" -ErrorAction SilentlyContinue))
  {
    gpg-connect-agent /bye
  }
  if (!(Get-Process "keyboxd" -ErrorAction SilentlyContinue))
  {
    gpg-connect-agent --keyboxd
  }
}

function Stop-GPG
{
  Stop-Process -Name "gpg-agent"
  Stop-Process -Name "keyboxd"
}
