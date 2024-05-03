$commandOverride = [ScriptBlock]{ param($Location) Write-Host $Location }

Set-PsFzfOption -AltCCommand $commandOverride

Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

Set-PsFzfOption -PSReadlineChordProvider "Ctrl+e" -PSReadlineChordReverseHistory "Ctrl+r" -GitKeyBindings -TabExpansion

function fzfcd
{
  $file = fzf --preview "bat --color=always {1} --style=numbers --line-range=:500 {}" --preview-label "Bat Preview" --header "FZF Preview" --header-first 
  if ($file)
  {
    Set-Location $(Split-Path -Path $file -Parent)
  } else
  {
    Write-Host "No file was selected"
  }
}

Set-PSReadLineKeyHandler -Key "Ctrl+f" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("fzfcd")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
