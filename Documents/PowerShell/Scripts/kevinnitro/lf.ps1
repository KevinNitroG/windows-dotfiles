# Sorce: https://github.com/gokcehan/lf/blob/master/etc/lfcd.ps1

function lfcd
{
  lf -print-last-dir $args | Set-Location
}

Set-PSReadLineKeyHandler -Key "Ctrl+Shift+d" -ScriptBlock { 
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("lfcd")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
