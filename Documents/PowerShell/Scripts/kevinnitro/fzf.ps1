Import-Module Catppuccin

# Ref: https://github.com/catppuccin/powershell#profile-usage 
# https://github.com/catppuccin/fzf - not use background for transparent
$Flavor = $Catppuccin['Mocha']
$env:FZF_DEFAULT_OPTS=@"
--color=hl:$($Flavor.Red),fg:$($Flavor.Text),header:$($Flavor.Red)
--color=info:$($Flavor.Mauve),pointer:$($Flavor.Rosewater),marker:$($Flavor.Rosewater)
--color=fg+:$($Flavor.Text),prompt:$($Flavor.Mauve),hl+:$($Flavor.Red)
--color=border:$($Flavor.Surface2)
--layout=reverse
--cycle
--scroll-off=5
--border
--preview-window=right,60%,border-left
--bind ctrl-u:preview-up,ctrl-d:preview-down,ctrl-space:toggle-preview
"@

$commandOverride = [ScriptBlock]{ param($Location) Write-Host $Location }

Set-PsFzfOption -AltCCommand $commandOverride

Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

Set-PsFzfOption -PSReadlineChordProvider "Ctrl+e" -PSReadlineChordReverseHistory "Ctrl+r" -GitKeyBindings -TabExpansion -EnableAliasFuzzyGitStatus -EnableAliasFuzzyEdit -EnableAliasFuzzyFasd -EnableAliasFuzzyKillProcess -EnableAliasFuzzyScoop

function _open_path
{
  param (
    [string]$inputPath
  )

  if (-not $inputPath)
  {
    Write-Output "No choice"
    return
  }

  Write-Output "[ ] cd"
  Write-Output "[*] nvim"

  $choice = Read-Host "Enter your choice"

  if ($inputPath -match "^.*:\d+:.*$")
  {
    $inputPath = ($inputPath -split ":")[0]
  }

  switch ($choice)
  {
    {$_ -eq "" -or $_ -eq " "}
    {
      if (Test-Path -Path $inputPath -PathType Leaf)
      {
        $inputPath = Split-Path -Path $inputPath -Parent
      }
      Set-Location -Path $inputPath
    }
    default
    { nvim $inputPath 
    }
  }
}

function _get_path_using_fzf
{
  $input_path = fzf --preview "bat --color=always {1} --style=numbers --line-range=:500 {}" --preview-label "Preview" --header "FZF" --header-first --prompt "File> "
  return $input_path
}

function _get_path_using_rg
{
  $INITIAL_QUERY = "${*:-}"
  $input_path = rg --ignore-case --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi --disabled --query "$INITIAL_QUERY" `
      --color "hl:-1:underline,hl+:-1:underline:reverse" `
      --delimiter ":" `
      --preview "bat --color=always {1} --style=numbers" `
      --preview-label "Preview" --header "Ripgrep" --header-first `
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
  return $input_path
}

function _get_path_using_fd
{
  $input_path = fd --type d --follow --hidden --exclude .git | fzf --preview 'tree /A {}'
  return $input_path
}


function fzfg
{
  _open_path $(_get_path_using_fzf)
}

function rgg
{
  _open_path $(_get_path_using_rg)
}

function fdg
{
  _open_path $(_get_path_using_fd)
}

Set-PSReadLineKeyHandler -Key "Ctrl+f" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("fzfg")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Key "Ctrl+g" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("rgg")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Key "Ctrl+Shift+d" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("fdg")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
