Set-Alias -Name ss -Value Select-String

if (Get-Command lazygit)
{
  Set-Alias -Name lg -Value lazygit 
}

Set-Alias -Name e -Value explorer.exe

if (Get-Command eza)
{
  Set-Alias -Name ls -Value eza
}
