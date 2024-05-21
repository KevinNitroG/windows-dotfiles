$SCOOP_FONTS = @(
  "nerd-fonts/JetBrainsMono-NF",
  "nerd-fonts/Noto-NF"
)

$SCOOP_COMPLETIONS = @(
  "extras/dockercompletion",
  "extras/scoop-completion"
)

$SCOOP_NECESSARYS = @(
  "extras/winrar",
  "main/7zip",
  "main/openssh",
  "main/unrar",
  "main/wget",
  "main/winget"
)

$SCOOP_CODE_EDITORS = @(
  "extras/vscode",
  "extras/windows-terminal",
  "extras/alacritty",
  "main/neovim"
  # "extra/sublime-text"
)

$SCOOP_OFTEN_USE_APPS = @(
  "extras/anydesk",
  "extras/authy",
  "extras/obs-studio",
  "extras/powertoys",
  "extras/vlc",
  "extras/winaero-tweaker",
  "main/warp",
  "nonportable/parsec-np"
  # "extra/spotify",
  # "extras/everything",
  # "extras/spicetify-themes", 
  # "main/spicetify-cli",
)

$SCOOP_CODING_TOOLS = @(
  "extras/autohotkey",
  "extras/keyviz",
  "extras/komorebi",
  "extras/lazygit",
  "extras/posh-git"
  "extras/psfzf",
  "extras/psreadline",
  "extras/terminal-icons",
  "main/actionlint",
  "main/adb",
  "main/bat",
  "main/delta",
  "main/eza",
  "main/fastfetch",
  "main/fd",
  "main/ffmpeg",
  "main/fzf",
  "main/gh",
  "main/gnupg",
  "main/gpg",
  "main/grep",
  "main/gzip",
  "main/jq",
  "main/lazydocker",
  # "main/lf",
  "main/poppler",
  "main/rclone",
  "main/ripgrep",
  "main/sd",
  "main/sed",
  "main/starship",
  "main/sudo",
  "main/tldr",
  "main/touch",
  "main/unar",
  "main/vivetool",
  "main/wakatime-cli",
  "main/xh",
  "main/yazi",
  "main/yt-dlp",
  "main/zoxide",
  "sysinternals/whois"
  # "main/oh-my-posh"
)

$SCOOP_OTHER_APPS = @(
  "extras/putty",
  "extras/v2rayn"
  "extras/winscp",
  "main/openssl",
  "nonportable/winfsp-np"
)
$PIP_APPS = @(
  "thefuck",
  "yewtube"
)

Install-Module -Name CompletionPredictor -Repository PSGallery -Force

scoop install $SCOOP_FONTS $SCOOP_COMPLETIONS $SCOOP_NECESSARYS $SCOOP_CODE_EDITORS $SCOOP_OFTEN_USE_APPS $SCOOP_CODING_TOOLS $SCOOP_OTHER_APPS

pip install $PIP_APPS
