function Start-GPG
{
  gpgconf --launch gpg-agent
}

function Stop-GPG
{
  Stop-Process -Name "gpg-agent" -ErrorAction SilentlyContinue
}
