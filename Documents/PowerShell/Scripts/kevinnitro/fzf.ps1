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

function fzfcd
{
  $file = fzf --preview "bat --color=always {1} --style=numbers --line-range=:500 {}" --preview-label "Bat Preview" --header "FZF Preview" --header-first 
  Write-Host $file
  Write-Host 
  if ($file)
  {
    $destination = $(Split-Path -Path $file -Parent)
    if ($destination)
    {
      Set-Location $destination
    }
  } else
  {
    Write-Host "No file was selected"
  }
}

Set-PSReadLineKeyHandler -Key "Ctrl+g" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("fzfcd")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

