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
  "actionlint",
  "autohotkey"
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
  "komorebi"
)

function List-ChocoApps
{
  $apps = $(choco list --id-only --no-color).Split("\n")
  $apps = $apps[1..($apps.Length - 2)]
  $apps = $apps | fzf --prompt="List Choco Apps  " --height=~80% --layout=reverse --border --cycle --margin="2,20" --padding=1 --multi
  return $apps
}

function List-ScoopApps
{
  $apps = $(scoop list | Select-Object -ExpandProperty "Name").Split("\n")
  $apps = $apps[1..($apps.Length - 1)]
  $apps = $apps | fzf --prompt="List Scoop Apps  " --height=~80% --layout=reverse --border --cycle --margin="2,20" --padding=1 --multi
  return $apps
}

function Upgrade-ChocoApps
{
  Write-Host "Please run with Administrator permission"
  $apps_set = New-Object System.Collections.Generic.HashSet(System.String)
  foreach($app in List-ChocoApps)
  {
    $apps_set.Add($app)
  }
  $include = Read-Host "Include predefine apps to update [Y/n]: "
  if ($include)
  {
    foreach ($app in $CHOCO_APPS_TO_UPGRADE)
    {
      $apps_set.Add($app)
    }
  }
  $apps_string = ($apps_set -split ",") -join " "
  choco upgrade $apps_string -y
}

function Upgrade-ScoopApps
{
  $apps_set = New-Object System.Collections.Generic.HashSet(System.String)
  foreach($app in List-ScoopApps)
  {
    $apps_set.Add($app)
  }
  $include = Read-Host "Include predefine apps to update [Y/n]: "
  if ($include)
  {
    foreach ($app in $SCOOP_APPS_TO_UPGRADE)
    {
      $apps_set.Add($app)
    }
  }
  $apps_string = ($apps_set -split ",") -join " "
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
  $apps = List-ChocoApps -join " "
  choco uninstall $apps -y
}

function Uninstall-ScoopApps
{
  $apps = List-ScoopApps -join " "
  scoop uninstall $apps
}

