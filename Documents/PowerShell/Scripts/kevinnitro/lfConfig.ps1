# Sorce: https://github.com/gokcehan/lf/blob/master/etc/lfcd.ps1

function lfcd
{
  lf | Set-Location
}

Set-PSReadLineKeyHandler -Key "Ctrl+d" -ScriptBlock { lfcd }
