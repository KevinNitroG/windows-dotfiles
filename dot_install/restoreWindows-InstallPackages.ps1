# INSTALL POWERSHELL MODULES

Install-Module -Name PSReadLine -Force -SkipPublisherCheck
Install-Module -Name CompletionPredictor -Repository PSGallery -Force
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Install-Module -Name posh-git -Force
Install-Module -Name PSFzf -Force

choco install `
  # NECESSARY
  winget-cli `
  wget `
  winrar `
  7zip `
  internet-download-manager `
  openssh `
  # CODE EDITOR / IDE
  microsoft-windows-terminal `
  neovim `
  vscode `
  sublimetext3 `
  # ENVIRONMENT, LANGUAGE
  llvm `
  mingw `
  gnuwin32-coreutils.install `
  nodejs `
  python `
  javaruntime `
  rust `
  # APPS
  powertoys `
  warp `
  vlc `
  spotify `
  # spicetify-cli ` spicetify-marketplace ` authy-desktop `
  obs-studio.install `
  anydesk `
  parsec `
  ultraviewer `
  # OTHER APPS
  itunes `
  putty `
  openssl `
  winfsp `
  winscp `
  docker-desktop `
  # OTHER TOOLS
  lf `
  winfetch `
  ffmpeg `
  yt-dlp `
  lazygit `
  zoxide `
  fzf `
  ripgrep `
  fd `
  jq `
  sed `
  bat `
  delta `
  tldr `
  whois `
  adb `
  gh `
  gzip `
  vivetool `
  v2rayn `
  -y

# INSTALL OH-MY-POSH

winget install JanDeDobbeleer.OhMyPosh -s winget

scoop install sudo
scoop install touch
scoop bucket add extras
scoop install keyviz

pip install thefuck
