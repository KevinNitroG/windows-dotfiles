# Stand for chezmoi sync
function cms
{
  Set-Location
  if (!(Get-Process "gpg-agent" -ErrorAction SilentlyContinue))
  {
    gpg-connect-agent /bye
  }
  chezmoi re-add
  Set-Location "$env:USERPROFILE/.local/share/chezmoi"
  git commit --message "$(Get-Date -Format 'h:mm tt on d/M/y')"
  git push
  # chezmoi git apply -R
  Stop-Process "gpg-agent"
}

function Update-ChezmoiCompletion
{
  chezmoi completion powershell --output "$env:USERPROFILE/Documents/PowerShell/Modules/chezmoi/completion.ps1"
}
