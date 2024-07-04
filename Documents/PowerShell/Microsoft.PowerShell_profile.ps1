# Let the script run even on error
# $ErrorActionPreference = "SilentlyContinue"

# VARIABLES
$env:EDITOR = "nvim"
$env:VISUAL = "code"
$env:PAGER = "delta"
$env:PYTHONIOENCODING = "utf-8" # To fix thefuck

# If is in non-interactive shell, then return
if (!([Environment]::UserInteractive -and -not $([Environment]::GetCommandLineArgs() | Where-Object{ $_ -like '-NonI*' })))
{
  return
}

$env:DEFAULT_NVIM_CONFIG = "nvim"
$env:NVIM_CONFIGS = @(
  "nvim",
  "LazyVim",
  "NvChad"
)

# Starship config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/starship.ps1"

Import-Module DockerCompletion
# Import-Module Terminal-Icons
# Import-Module posh-wakatime
Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$env:USERPROFILE\.config\wakatime\posh-wakatime\posh-wakatime.psm1"
Import-Module CompletionPredictor
Import-Module posh-git
Import-Module Catppuccin
import-module PsReadLine

$Flavor = $Catppuccin['Mocha']

# oh-my-posh
# oh-my-posh init pwsh --config "$env:LOCALAPPDATA/Programs/oh-my-posh/themes/$env:OHMYPOSH_THEME.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:USERPROFILE/.config/ohmyposh/themes/kevinnitro.omp.json" | Invoke-Expression

# Thefuck
# Invoke-Expression "$(thefuck --alias)"

# zoxide
Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })

# gh completion
Invoke-Expression (& { (gh completion -s powershell | Out-String) })

# PSReadLine config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/PSReadLine.ps1"

# Rclone
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/rclone.ps1"

# fzf config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/Fzf.ps1"

# Bat config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/bat.ps1"

# Yazi config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/yazi.ps1"

# Eza config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/eza.ps1"

# Typing config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/typing.ps1"

# Alias config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/setAlias.ps1"

# Update Spicetify
# . "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/spicetifyUpdate.ps1"

# Update oh-my-posh
# . "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/updateOhMyPosh.ps1"

# Check wifi password
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/checkWifiPassword.ps1"

# Check battery 
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/checkBattery.ps1"

# Chezmoi tab completion
# Note that it will work only when you type chezmoi
# . "$env:USERPROFILE/Documents/PowerShell/Modules/chezmoi/completion.ps1"

# Chezmoi config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/chezmoi.ps1"

# Apps manage
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/appsManage.ps1"

# Vscode-CPPTools
# . "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/vscode-cpptools.ps1"

# Neovim config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/neovim.ps1"

# Cheat sheet from The Primeagen
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-cht.sh
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/chtsh.ps1"

# Linux like comma"for Windows
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/linuxLike.ps1"

# Komorebi config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/komorebi.ps1"

# GPG
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/gpg.ps1"

# Cloudflare WARP
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/cloudflareWARP.ps1"

# Githelpers
# . "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/gitHelpers.ps1"

# Clean (Delete recycle bin, temp, cache, disk cleanup)
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/clean.ps1"

# Update Stylus
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/stylus.ps1"

# Utils
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/utils.ps1"

# PSStyle Catppuccin
# Ref: https://github.com/catppuccin/powershell#profile-usage
$PSStyle.Formatting.Debug = $Flavor.Sky.Foreground()
$PSStyle.Formatting.Error = $Flavor.Red.Foreground()
$PSStyle.Formatting.ErrorAccent = $Flavor.Blue.Foreground()
$PSStyle.Formatting.FormatAccent = $Flavor.Teal.Foreground()
$PSStyle.Formatting.TableHeader = $Flavor.Rosewater.Foreground()
$PSStyle.Formatting.Verbose = $Flavor.Yellow.Foreground()
$PSStyle.Formatting.Warning = $Flavor.Peach.Foreground()


# For stop cursor from blinking
Write-Host "`e[?12l"

# Fastfetch to flex ~.~
fastfetch
