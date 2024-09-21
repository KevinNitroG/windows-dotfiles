$SCOOP_APPS = @(
  "extras/googlechrome",
  "main/git",
  "main/chezmoi",
  "main/pwsh"
)


Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

scoop bucket add main
scoop bucket add extras
scoop bucket add nonportable
scoop bucket add sysinternals
scoop bucket add java
scoop bucket add nerd-fonts
scoop bucket add versions
# scoop bucket add neorocks-scoop https://github.com/nvim-neorocks/rocks-scoop.git

scoop install @SCOOP_APPS
