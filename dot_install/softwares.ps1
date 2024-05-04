# INSTALL POWERSHELL MODULES

$CHOCO_NECCESSARY = @(
  "winget-cli",
  "wget",
  "winrar",
  "7zip",
  "internet-download-manager",
  "openssh"
)
$CHOCO_CODE_EDITOR = @(
  "microsoft-windows-terminal",
  "neovim",
  "vscode",
  "sublimetext3"
)
$CHOCO_OFTEN_USE_APPS = @(
  "powertoys",
  # "everything",
  # "everythingpowertoys",
  "warp",
  "vlc",
  # "spotify",
  # "spicetify-cli",
  # " spicetify-marketplace", 
  "authy-desktop",
  "obs-studio.install",
  "anydesk",
  "parsec",
  "winaero-tweaker"
  # "ultraviewer"
)
$CHOCO_CODING_TOOLS = @(
  "zoxide",
  "lazygit",
  "fzf",
  "ripgrep",
  "winfetch",
  "ffmpeg",
  "yt-dlp",
  "fd",
  "jq",
  "sed",
  "bat",
  "delta",
  "tldr",
  "whois",
  "adb",
  "gh",
  "gzip",
  "vivetool",
  "xh"
)
$CHOCO_OTHER_APPS = @(
  "itunes",
  "putty",
  "openssl",
  "winfsp",
  "winscp",
  "v2rayn"
)
$SCOOP_APPS = @(
  "komorebi",
  "autohotkey",
  "sudo",
  "touch",
  "lf",
  "keyviz",
  "sd",
  "eza",
  "fastfetch"
)

Install-Module -Name PSReadLine -Force -SkipPublisherCheck
Install-Module -Name CompletionPredictor -Repository PSGallery -Force
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Install-Module -Name posh-git -Force
Install-Module -Name PSFzf -Force

choco install $CHOCO_NECCESSARY $CHOCO_CODE_EDITOR $CHOCO_OFTEN_USE_APPS $CHOCO_CODING_TOOLS $CHOCO_OTHER_APPS
-y

# INSTALL OH-MY-POSH

# winget install JanDeDobbeleer.OhMyPosh -s winget

scoop bucket add extras
scoop install $SCOOP_APPS

pip install thefuck
