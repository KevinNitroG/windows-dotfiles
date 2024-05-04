$CHOCO_APPS_TO_UPGRADE = @(
  "git",
  "neovim",
  "chezmoi",
  "fd",
  "fzf",
  "lazygit",
  "obs-studio.install",
  "powertoys",
  "vlc",
  "zoxide",
  "bat",
  "delta",
  "tldr",
  "actionlint",
  "xh"
)
$SCOOP_APPS_TO_UPGRADE = @(
  "sudo",
  "touch",
  "komorebi",
  "autohotkey",
  "lf",
  "eza",
  "sd",
  "fastfetch"
)
$PIP_APPS_TO_UPGRADE = @(
  "thefuck",
  "cpplint",
  "ruff"
)
$NPM_APPS_TO_UPGRADE = @(
  "markdownlint",
  "eslint",
  "prettier"
)
$POWERSHELL_MODULES_TO_UPDATE = @(
  "PSReadLine",
  "CompletionPredictor",
  "posh-git",
  "Terminal-Icons",
  "posh-wakatime"
)

function List-ChocoApps
{
  $apps = $(choco list --id-only --no-color).Split("\n")
  $apps = $apps[1..($apps.Length - 2)]
  return $apps
}

function List-ScoopApps
{
  $apps = $(scoop list | Select-Object -ExpandProperty "Name").Split("\n")
  $apps = $apps[1..($apps.Length - 1)]
  return $apps
}

function Select-Apps
{
  param (
    [string[]] $apps
  )
  $apps = $apps | fzf --prompt="Select Apps  " --height=~80% --layout=reverse --border --cycle --margin="2,20" --padding=1 --multi
  return $apps
}

function Upgrade-ChocoApps
{
  $apps_set = New-Object System.Collections.Generic.HashSet[[String]]
  $installed_apps = List-ChocoApps
  foreach ($app in Select-Apps $installed_apps)
  {
    $apps_set.Add($app) >$null
  }
  $include = $(Read-Host "Include predefine apps to update [Y/n]").ToUpper()
  if ($include -eq "Y" -or $include -eq "")
  {
    foreach ($app in $CHOCO_APPS_TO_UPGRADE)
    {
      if ($installed_apps -contains $app)
      {
        $apps_set.Add($app) >$null
      }
    }
  }
  if ($apps_set.Length)
  {
    $apps_string = ($apps_set -split ",")
    if (Check-IsAdmin)
    {
      choco upgrade $apps_string -y
    } else
    {
      if (Get-Command sudo -ErrorAction SilentlyContinue)
      {
        sudo choco upgrade $apps_string -y
      } else
      {
        Write-Host "Please run with administrator privileges"
      }
    }
  }
}

function Upgrade-ScoopApps
{
  $apps_set = New-Object System.Collections.Generic.HashSet[[String]]
  $installed_apps = List-ScoopApps
  foreach ($app in Select-Apps $installed_apps)
  {
    $apps_set.Add($app) >$null
  }
  $include = $(Read-Host "Include predefine apps to update [Y/n]").ToUpper()
  if ($include -eq "Y" -or $include -eq "")
  {
    foreach ($app in $SCOOP_APPS_TO_UPGRADE)
    {
      if ($installed_apps -contains $app)
      {
        $apps_set.Add($app) >$null
      }
    }
  }
  if ($apps_set.Length)
  {
    $apps_string = ($apps_set -split ",")
    scoop update $apps_string
  } else
  {
    Write-Host "No app was selected to update"
  }
}
function Upgrade-NpmApps
{
  $apps_string = $NPM_APPS_TO_UPGRADE -join " "
  npm upgrade $apps_string
}

function Upgrade-PipApps
{
  $apps_string = $PIP_APPS_TO_UPGRADE -join " "
  pip install --upgrade $apps_string
}

function Update-PowershellModules
{
  # Update-Module -Name $POWERSHELL_MODULES_TO_UPDATE -AcceptLicense -Force
  Update-Module -AcceptLicense -Force
}


function Uninstall-ChocoApps
{
  $apps = Select-Apps $(List-ChocoApps)
  choco uninstall $apps -y
}

function Uninstall-ScoopApps
{
  $apps = Select-Apps $(List-ScoopApps)
  scoop uninstall $apps
}
