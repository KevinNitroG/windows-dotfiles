# Let the script run even on error
# $ErrorActionPreference = "SilentlyContinue"

# VARIABLES
# $env:CPLUS_INCLUDE_PATH = "C:/ProgramData/mingw64/mingw64/lib/gcc/x86_64-w64-mingw32/13.2.0/include/c++/x86_64-w64-mingw32;C:/Program Files/LLVM/lib/clang/18/include;C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.39.33519/include;C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.39.33519/atlmfc/include"
$env:OHMYPOSH_THEME = "star"
$env:DEFAULT_NVIM_CONFIG = "nvim-alexis12119"
$env:NVIM_CONFIGS = @(
  "nvim-alexis12119",
  "LazyVim",
  "NvChad"
)

# https://github.com/catppuccin/fzf - not use background for transparent
$env:FZF_DEFAULT_OPTS=@"
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--layout=reverse
--cycle
--scroll-off=5
--border
--preview-window=right,60%,border-left
--bind ctrl-u:preview-up,ctrl-d:preview-down
"@

$env:BAT_THEME = "Catppuccin Mocha"

# to fix thefuck
$env:PYTHONIOENCODING = "utf-8"

# Import-Module -Name Terminal-Icons
# Import-Module -Name posh-wakatime
import-module -Name PsReadLine
Import-Module -Name CompletionPredictor
Import-Module -Name posh-git
# Import-Module -Name "$env:USERPROFILE\KevinNitro-Files\posh-wakatime\posh-wakatime.psm1"
Import-Module -Name "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# oh-my-posh
oh-my-posh init pwsh --config "$env:LOCALAPPDATA/Programs/oh-my-posh/themes/$env:OHMYPOSH_THEME.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:USERPROFILE/.config/ohmyposh/themes/kevinnitro.omp.json" | Invoke-Expression

# Thefuck
Invoke-Expression "$(thefuck --alias)"

# zoxide
Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })

# PSReadLine config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/PSReadLineConfig.ps1"

# fzf config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/FzfConfig.ps1"

# Bat config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/batConfig.ps1"

# Alias config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/setAlias.ps1"

# Dotfiles config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/dotfiles.ps1"

# Update Spicetify
# . "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/spicetifyUpdate.ps1"

# Update oh-my-posh
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/updateOhMyPosh.ps1"

# Check wifi password
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/checkWifiPassword.ps1"

# Check battery 
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/checkBattery.ps1"

# Apps manage
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/appsManage.ps1"

# Neovim config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/neovimConfig.ps1"

# Lf config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/lfConfig.ps1"

# Cheat sheet from The Primeagen
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-cht.sh
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/chtsh.ps1"

# Linux like comma"for Windows
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/linuxLike.ps1"

# Komorebi config
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/komorebiConfig.ps1"

# Utils
. "$env:USERPROFILE/Documents/PowerShell/Scripts/kevinnitro/utils.ps1"