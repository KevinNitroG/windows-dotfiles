# Stand for chezmoi sync
function cms
{
  $current_dir = Get-Location
  Set-Location
  if (!(Get-Process "gpg-agent" -ErrorAction SilentlyContinue))
  {
    gpg-connect-agent /bye
  }
  if (!(Get-Process "keyboxd" -ErrorAction SilentlyContinue))
  {
    gpg-connect-agent --keyboxd
  }
  chezmoi re-add
  Set-Location "$env:USERPROFILE/.local/share/chezmoi"
  git f
  # chezmoi git apply -R
  Stop-Process -Name "gpg-agent"
  Stop-Process -Name "keyboxd"
  Set-Location $current_dir
}

function Update-ChezmoiCompletion
{
  chezmoi completion powershell --output "$env:USERPROFILE/Documents/PowerShell/Modules/chezmoi/completion.ps1"
}

Set-Alias -Name cm -Value chezmoi

function cmc
{
  param (
    [string] $msg
  )
  if ($msg)
  {
    chezmoi git commit -m "$msg"
  } else 
  {
    chezmoi git commit
  }
  chezmoi git push
}

function cmp
{
  chezmoi git push
}
