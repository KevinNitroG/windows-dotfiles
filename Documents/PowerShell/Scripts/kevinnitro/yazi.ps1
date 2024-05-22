Set-Alias -Name yz -Value yazi

function yzcd
{
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
  {
    Set-Location -LiteralPath $cwd
  }
  Remove-Item -Path $tmp
}

Set-PSReadLineKeyHandler -Key "Ctrl+Shift+d" -ScriptBlock { 
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("yzcd")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
