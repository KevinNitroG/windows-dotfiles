#!/bin/bash

CHEZMOI_DOTFILES='git@github.com:KevinNitroG/dotfiles.git'

DISTRO=$(lsb_release -i | awk '{print $NF}')
export DISTRO

##########################################

PIP_PACKAGES=(
)

NPM_PACKAGES=(
  'commitizen'
  'create-react-app'
  'tree-sitter-cli'
)

##########################################

has() {
  command -v "$1" >/dev/null
}

##########################################

read -p -r 'MAKE SURE YOU RUN THIS SCRIPT IN USER PRIVILEDGE? (y/N): ' yn

case $yn in
[yY]) ;;
*) exit 1 ;;
esac

read -p -r 'MAKE SURE YOU HAVE IMPORTED SSH, GPG KEY? (Y/n): ' yn

case $yn in
[nN]) exit 1 ;;
*) ;;
esac

##########################################

# NOTE: Use source instead of bash to avoid create subshell
case "$DISTRO" in
'Arch')
  # shellcheck disable=SC1090
  source <(curl -fsSL 'https://raw.githubusercontent.com/KevinNitroG/dotfiles/main/dot_install/linux/install-arch.sh')
  ;;
*)
  echo 'Unsupport distro!'
  exit 1
  ;;
esac

##########################################

# Change default shell to zsh
if has zsh; then
  echo "CHANGE DEFAULT SHELL TO ZSH..."
  chsh -s "$(which zsh)"
fi

# RESTORE CHEZMOI
if has chezmoi; then
  echo 'CHEZMOI RESTORE...'
  chezmoi init --apply --verbose $CHEZMOI_DOTFILES
else
  echo 'CHEZMOI NOT FOUND!'
fi

# TPM FOR TMUX
if has tmux; then
  echo 'INSTALLING TPM FOR TMUX...'
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# PATCH SPOTIFY
if has spotify; then
  echo 'PATCHING SPOTIFY USING SPOTX...'
  bash <(curl -sSL https://spotx-official.github.io/run.sh)
fi

# BAT CACHE THEMES
if has bat; then
  echo "BAT CACHE BUILD..."
  bat cache --build
fi

# CONFIGURE TLP
if has tlp; then
  echo 'CONFIGURING TLP...'
  sudo rm /etc/tlp.conf || true
  sudo ln -s ~/.config/tlp/tlp.conf /etc/tlp.conf
  sudo systemctl enable tlp.service
  sudo systemctl start tlp.service
  if has tlp-rdw; then
    sudo systemctl enable NetworkManager-dispatcher.service
  fi
  sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
fi

if has npm; then
  echo "CONFIG NPM..."
  mkdir -p ~/.npm-global/
fi

if has crontab; then
  echo "INSTALL CRONTAB..."
  crontab ~/.config/crontab/kevinnitro
fi

if has docker; then
  echo "SETUP DOCKER..."
  sudo rm "$HOME/.docker/" -rf || true
  sudo groupadd docker
  sudo usermod -aG docker "$USER"
  newgrp docker
fi

if has kanata; then
  echo "SETUP KANATA..."
  sudo groupadd uinput
  sudo usermod -aG input "$USER"
  sudo usermod -aG uinput "$USER"
  echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee -a '/etc/udev/rules.d/99-input.rules'
  sudo udevadm control --reload-rules && sudo udevadm trigger
  sudo modprobe uinput || echo 'please run "sudo modprobe uinput" for the first time run kanata'
  systemctl --user enable kanata.service || echo 'Cannot enable kanata service. Try to enable manually :)'
fi

if has rclone && [ -f "$HOME/.config/rclone/rclone.conf" ]; then
  echo "SETUP MOUNTING RCLONE DRIVE..."
  mkdir -p "$HOME/mount/rclone-drives"
  systemctl --user start rclone-drives.services
  systemctl --user enable rclone-drives.services
fi

# NOTE: Mason can do that bruh. Just 20h ago it was merged.
#
# if has Hyprland && has go; then
#   echo "INSTALL HYPRLS..."
#   go install github.com/ewen-lbh/hyprls/cmd/hyprls@latest
# fi

##########################################

read -p -r 'INSTALL OTHER PACKAGES (pip, npm,...)? [Y/n]: ' yn

case $yn in
[yY])
  if has pip; then
    pip install "${PIP_PACKAGES[@]}"
  else
    echo 'PIP IS NOT INSTALLED!'
  fi
  if has npm; then
    npm install -g "${NPM_PACKAGES[@]}"
  else
    echo 'NPM IS NOT INSTALLED!'
  fi
  ;;
esac
