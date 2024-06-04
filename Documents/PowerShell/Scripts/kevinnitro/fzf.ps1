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
  $input_path = fd --type file --follow --hidden --exclude .git |
    fzf --prompt 'Files> ' `
      --header-first `
      --header 'CTRL-S: Switch between Files/Directories' `
      --bind 'ctrl-s:transform:if not "%FZF_PROMPT%"=="Files> " (echo ^change-prompt^(Files^> ^)^+^reload^(fd --type file^)) else (echo ^change-prompt^(Directory^> ^)^+^reload^(fd --type directory^))' `
      --preview 'if "%FZF_PROMPT%"=="Files> " (bat --color=always {} --style=plain) else (eza -T --colour=always --icons=always {})'
  return $input_path
}

function _get_path_using_rg
{
  $INITIAL_QUERY = "${*:-}"
  $RG_PREFIX = "rg --column --line-number --no-heading --color=always --smart-case"
  $input_path = "" |
    fzf --ansi --disabled --query "$INITIAL_QUERY" `
      --bind "start:reload:$RG_PREFIX {q}" `
      --bind "change:reload:sleep 0.2 & $RG_PREFIX {q} || rem" `
      --bind 'ctrl-s:transform:if not "%FZF_PROMPT%" == "1. ripgrep> " (echo ^rebind^(change^)^+^change-prompt^(1. ripgrep^> ^)^+^disable-search^+^transform-query:echo ^{q^} ^> %TEMP%\rg-fzf-f ^& cat %TEMP%\rg-fzf-r) else (echo ^unbind^(change^)^+^change-prompt^(2. fzf^> ^)^+^enable-search^+^transform-query:echo ^{q^} ^> %TEMP%\rg-fzf-r ^& cat %TEMP%\rg-fzf-f)' `
      --color "hl:-1:underline,hl+:-1:underline:reverse" `
      --delimiter ":" `
      --prompt '1. ripgrep> ' `
      --preview-label "Preview" `
      --header 'CTRL-S: Switch between ripgrep/fzf' `
      --header-first `
      --preview 'bat --color=always {1} --highlight-line {2} --style=plain' `
      --preview-window 'up,60%,border-bottom,+{2}+3/3'
  return $input_path
}

function _get_path_using_fd
{
  $input_path = fd --type directory --follow --hidden --exclude .git |
    fzf --prompt 'Directories> ' `
      --header-first `
      --preview 'eza -T --colour=always --icons=always {}'
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
