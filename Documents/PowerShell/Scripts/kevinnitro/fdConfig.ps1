function fdcd
{
  $path = fd --type d --follow --hidden --exclude .git | fzf
  Set-Location $path
}

Set-PSReadLineKeyHandler -Key "Ctrl+d" -ScriptBlock {
  fdcd
}
