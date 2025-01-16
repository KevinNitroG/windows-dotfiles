#!/bin/bash

PACKAGES=(
  # Essentials
  # 'google-chrome'
  'brave-bin'
  'chezmoi'
  'git'
  'kanata-bin' # Change keyboard func
  'lazygit'
  'tmux'
  'wget'
  'zsh'

  # Terminal
  'alacritty'

  # Text / Code Editor, IDE
  'mysql-workbench'
  'neovim'
  'visual-studio-code-bin'
  'zed'

  # CLI Power Basics
  # 'aria2'
  # 'trash-cli'
  # 'xsel'
  'atac'
  'bat'
  'doggo'
  'exa'
  'fd'
  'fzf'
  'gh'
  'git-delta'
  'github-cli'
  'glow'
  'jq'
  'lazydocker'
  'rclone'
  'ripgrep'
  'rsync'
  'sd'
  'thefuck'
  'tokei'
  'tree'
  'unzip'
  'wget'
  'xh'
  'yazi'
  'zip'
  'zoxide'

  # Development, languages, interpreters, compilers, etc
  # 'docker-desktop' # Docker desktop on Arch is not stable
  # 'go'
  # 'pnpm'
  # 'yarn'
  'clang'
  'cmake'
  'docker'
  'docker-compose'
  'gdb'
  'nodejs'
  'npm'
  'pyenv'
  'python-pip'
  'rustup'

  # Formatter, Linter
  # 'actionlint'
  # 'eslint'
  # 'prettier'
  # 'ruff'

  # Security Utilities
  'gnupg'
  'openssl'

  # Monitoring, management and stats
  # 'speedtest-cli'
  'btop'
  'cronie'

  # CLI Fun
  'cowsay'
  'fastfetch'
  'figlet' # A program for making large letters out of ordinary text
  'lolcat'

  # Apps / Tools
  # 'authy-desktop-win32-bin'
  'gammastep'
  'obs-studio'
  'qbittorrent-enhanced'
  'rclone'
  'screenkey'
  'spotify'
  'vlc'

  # Fonts
  'noto-fonts-emoji'
  'ttf-google-sans'
  'ttf-jetbrains-mono-nerd'
  'ttf-nerd-fonts-symbols'

  # Other but IDK what it is
  # 'pacman-contrib' # For paccache
  'fuse3'         # For rclone mount --daemon
  'gnome-keyring' # For MySQL Workbench
  'gtk4'
  'lsb-release'
  'tree'
  'wtype'
)

PACKAGES_LAPTOP=(
  # 'gestures'
  # 'libinput-gestures'
  'tlp'
  'tlp-rdw'
  'tlpui'
)

##########################################

# UPDATE SOURCES
echo 'UPDATE SOURCES...'
sudo pacman -Syu

# INSTALL YAY
if ! has yay; then
  echo 'INSTALLING YAY...'
  sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si && cd ..
else
  echo 'YAY INSTALLED'
fi

# INSTALL PACKAGES
echo 'INSTALLING PACKAGES...'
yay -S "${PACKAGES[@]}" --noconfirm

# NOTE: Already managed by chezmoi
# INSTALL OHMYZSH
# echo 'INSTALLING OHMYZSH...'
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# INSTALL LAPTOP STUFF
read -p -r 'INSTALL LAPTOP STUFF? [y/N]: ' yn
case $yn in
[yY])
  echo 'INSTALLING LAPTOP STUFF...'
  yay -S "${PACKAGES_LAPTOP[@]}" --noconfirm
  ;;
esac

# INSTALL HYPRDOTS
read -p -r 'INSTALL HYPRDOTS? [Y/n]: ' yn
case $yn in
[nN]) ;;
*)
  git clone --depth 1 https://github.com/prasanthrangan/hyprdots ~/HyDE
  chmod +x ~/Hyde/Scripts/install.sh
  ~/Hyde/Scripts/install.sh
  ;;
esac

##########################################

systemctl list-unit-files "cronie.service" &>/dev/null && sudo systemctl enable --now cronie.service
