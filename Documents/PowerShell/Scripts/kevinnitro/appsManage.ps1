$CHOCO_APPS_TO_UPGRADE = @(
  "git",
  "neovim",
  "chezmoi",
  "fd",
  "fzf",
  "lazygit",
  "lf",
  "obs-studio.install",
  "powertoys",
  "vlc",
  "zoxide",
  "bat",
  "delta",
  "tldr",
  "actionlint"
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
$SCOOP_APPS_TO_UPGRADE = @(
  "komorebi",
  "autohotkey",
  "sd"
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
  Write-Host "Please run with Administrator permission"
  $apps_set = New-Object System.Collections.Generic.HashSet[[String]]
  $installed_apps = List-ChocoApps
  foreach ($app in Select-Apps $installed_apps)
  {
    $apps_set.Add($app) >$null
  }
  $include = Read-Host "Include predefine apps to update [Y/n]"
  if ($include)
  {
    foreach ($app in $CHOCO_APPS_TO_UPGRADE)
    {
      if ($installed_apps -contains $app)
      {
        $apps_set.Add($app) >$null
      }
    }
  }
  $apps_string = ($apps_set -split ",")
  choco upgrade $apps_string -y
}

function Upgrade-ScoopApps
{
  $apps_set = New-Object System.Collections.Generic.HashSet[[String]]
  $installed_apps = List-ScoopApps
  foreach ($app in Select-Apps $installed_apps)
  {
    $apps_set.Add($app) >$null
  }
  $include = Read-Host "Include predefine apps to update [Y/n]: "
  if ($include)
  {
    foreach ($app in $SCOOP_APPS_TO_UPGRADE)
    {
      if ($installed_apps -contains $app)
      {
        $apps_set.Add($app) >$null
      }
    }
  }
  $apps_string = ($apps_set -split ",")
  scoop upgrade $apps_string
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
