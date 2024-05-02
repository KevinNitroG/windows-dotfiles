function rgcd
{
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

Set-PSReadLineKeyHandler -Key "Ctrl+g" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("rgcd")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
