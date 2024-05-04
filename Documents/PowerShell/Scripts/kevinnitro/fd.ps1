function fdcd
{
  $path = fd --type d --follow --hidden --exclude .git | fzf
  if ($path)
  {
    Set-Location $path
  } else
  {
    Write-Host "No directory was selected"
  }
}

Set-PSReadLineKeyHandler -Key "Ctrl+d" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("fdcd")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
