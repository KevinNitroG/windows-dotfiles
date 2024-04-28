# example command - use $Location with a different command:
$commandOverride = [ScriptBlock]{ param($Location) Write-Host $Location }
# pass your override to PSFzf:
Set-PsFzfOption -AltCCommand $commandOverride

Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -GitKeyBindings -TabExpansion

Set-PSReadLineKeyHandler -Key "Ctrl+f" -ScriptBlock {
  $file = fzf --preview "bat --color=always {1} --style=numbers --line-range=:500 {}" --preview-label "Bat Preview" --header "FZF Preview" --header-first 
  Set-Location $(Split-Path -Path $file -Parent)
}

Set-PSReadLineKeyHandler -Key "Ctrl+g" -ScriptBlock {
  # Source: https://news.ycombinator.com/item?id=38471822
  # Ref: https://github.com/junegunn/fzf/blob/master/ADVANCED.md#using-fzf-as-the-secondary-filter
  $result = rg --ignore-case --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi `
      --color "hl:-1:underline,hl+:-1:underline:reverse" `
      --delimiter ":" `
      --preview "bat --color=always {1} --style=numbers" `
      --preview-label "Bat Preview" --header "Ripgrep Preview" --header-first
  # --bind 'enter:become(echo "{1}")'
  if ($result)
  {
    Set-Location $(Split-Path -Path $result.Split(':')[0] -Parent)
  } else
  {
    "No file was selected"
  }
}
