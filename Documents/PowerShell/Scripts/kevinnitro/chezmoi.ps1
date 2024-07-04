Set-Alias -Name cm -Value chezmoi -Option AllScope

if (Get-Command "chezmoi" -ErrorAction SilentlyContinue)
{
  Invoke-Expression (& { (chezmoi completion powershell | Out-String) })
}

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
  if ($LASTEXITCODE -eq 0)
  {
    chezmoi git push
  }
}

function cma
{
  param (
    [string[]] $files
  )
  $current_dir = Get-Location
  for ($i = 0; $i -lt $files.Length; $i++)
  {
    $files[$i] = "$($current_dir)\$($files[$i])"
  }
  Set-Location
  chezmoi add $files $args
  Set-Location $current_dir
}

function cmp
{
  chezmoi git push
}

function cms
{
  $current_dir = Get-Location
  Set-Location
  if (!(Get-Process "gpg-agent" -ErrorAction SilentlyContinue))
  {
    gpg-connect-agent /bye
  }
  chezmoi re-add
  Set-Location $(chezmoi source-path)
  git f
  # chezmoi git apply -R
  # Stop-Process -Name "gpg-agent" -Force -ErrorAction Continue
  # Stop-Process -Name "keyboxd"
  Set-Location $current_dir
}
