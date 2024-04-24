# Stand for chezmoi sync
function cms
{
  Set-Location
  if (!(Get-Process "gpg-agent" -ErrorAction SilentlyContinue))
  {
    gpg-connect-agent /bye
  }
  chezmoi re-add
  chezmoi git commit -m "$(Get-Date -Format 'h:mm tt on d/M/y')"
  chezmoi git push
  # chezmoi git apply -R
  gpg-connect-agent killagent /bye
}
