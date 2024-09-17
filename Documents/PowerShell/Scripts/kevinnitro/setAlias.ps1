Set-Alias -Name ss -Value Select-String

if (Get-Command lazygit)
{
  Set-Alias -Name lg -Value lazygit 
}

Set-Alias -Name e -Value explorer.exe

Set-Alias -Name c -Value cls
Set-Alias -Name csl -Value cls

Set-Alias -Name shutdownnow -Value Stop-Computer
Set-Alias -Name rebootnow -Value Restart-Computer
