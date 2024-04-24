# KEVINNITRO WINDOWS DOTFILES

[![GitHub last commit (by committer)](https://img.shields.io/github/last-commit/KevinNitroG/KevinNitro-Windows-Dotfiles?style=for-the-badge&color=CAEDFF)](../../commits/main)
![GitHub repo size](https://img.shields.io/github/repo-size/KevinNitroG/KevinNitro-Windows-Dotfiles?style=for-the-badge&color=D8B4F8)

```fastfetch.ps1
> fastfetch

/////////////////  /////////////////    kevinnitro@Kevostro-Windows
/////////////////  /////////////////    ---------------------------
/////////////////  /////////////////    OS: Windows 11 (Home) x86_64
/////////////////  /////////////////    Host: Vostro 14 5410
/////////////////  /////////////////    Packages: 56 (choco)
/////////////////  /////////////////    Shell: PowerShell 7.4.1
/////////////////  /////////////////    Display (AUO5491): 1920x1080 @ 60Hz (as 1536x864) [Built-in]
/////////////////  /////////////////    DE: Fluent
                                        WM: Desktop Window Manager
/////////////////  /////////////////    WM Theme: Custom - Blue (System: Dark, Apps: Dark)
/////////////////  /////////////////    Icons: This PC, Recycle Bin, Control Panel
/////////////////  /////////////////    Font: Segoe UI (12pt) [Caption / Menu / Message / Status]
/////////////////  /////////////////    Cursor: W11 Cursors Dark HDPI default by Jepri Creations (32px)
/////////////////  /////////////////    Terminal: Windows Terminal 1.18.3181.0
/////////////////  /////////////////    Terminal Font: JetBrainsMono Nerd Font Mono (14pt)
/////////////////  /////////////////    CPU: 11th Gen Intel(R) Core(TM) i5-11320H (8) @ 2.50 GHz
/////////////////  /////////////////    GPU: Intel(R) Iris(R) Xe Graphics (128.00 MiB) [Integrated]
                                        Memory: 7.94 GiB / 23.75 GiB (33%)
                                        Swap: 81.21 MiB / 3.88 GiB (2%)
                                        Disk (C:\): 91.13 GiB / 250.00 GiB (36%) - NTFS
                                        Disk (D:\): 31.33 GiB / 138.39 GiB (23%) - NTFS
                                        Disk (E:\): 3.52 GiB / 99.94 GiB (4%) - ReFS
                                        Disk (Z:\): 151.02 GiB / 5.03 TiB (3%) - FUSE-rclone [External]
```

> [!WARNING]
>
> This repo may contains my personal information, please **DO NOT** use it.

---

## Table of Contents

- [KEVINNITRO WINDOWS DOTFILES](#kevinnitro-windows-dotfiles)
  - [Table of Contents](#table-of-contents)
  - [⚙️ SETUP](#️-setup)
  - [🪴 USE](#-use)
    - [1️⃣ ADD .SSH AND SOME FILES](#1️⃣-add-ssh-and-some-files)
    - [2️⃣ INSTALL CHOCO, GIT, POWERSHELL _(Admin)_](#2️⃣-install-choco-git-powershell-admin)
    - [3️⃣ CLONE REPO](#3️⃣-clone-repo)
    - [4️⃣ SET ENV PATH _(Admin)_](#4️⃣-set-env-path-admin)
    - [5️⃣ INSTALL POWERSHELL MODULES, CHOCO APPS, OH-MY-POSH _(Admin)_](#5️⃣-install-powershell-modules-choco-apps-oh-my-posh-admin)
    - [6️⃣ INSTALL FONTS](#6️⃣-install-fonts)
  - [🎈 EXTRAS](#-extras)
    - [Crack Winrar _(Admin)_](#crack-winrar-admin)
    - [Patch IDM](#patch-idm)
    - [Install \& Active Office](#install--active-office)
    - [Spictify](#spictify)
    - [Others](#others)
  - [📒 NOTES](#-notes)
    - [SSH](#ssh)
    - [GIT](#git)
      - [Git submodules](#git-submodules)
      - [Tracking files](#tracking-files)
    - [POWERSHELL](#powershell)
    - [WINDOWS](#windows)
      - [View current path](#view-current-path)
      - [Windows Variables](#windows-variables)
      - [DATETIME FORMAT](#datetime-format)

## ⚙️ SETUP

```setup.ps1
git init --bare $env:USERPROFILE/KevinNitro-Dotfiles

# Open powershell profile to add alias
notepad $PROFILE

# Add alias
function df {
	git --git-dir=$env:USERPROFILE/KevinNitro-Dotfiles/ --work-tree=$env:USERPROFILE $args
}
# Setup
df config --local core.autocrlf false
df config --local status.showUntrackedFiles no
df config --local user.name "KevinNitroG"
df config --local user.email "trannguyenthaibinh46@gmail.com"

df branch -m main
df remote add origin git@github.com:KevinNitroG/KevinNitro-Windows-Dotfiles.git
# df branch --set-upstream-to=origin/main main
git push --set-upstream origin main
```

## 🪴 USE

### 1️⃣ ADD .SSH AND SOME FILES

sth

Setup SSH _(Admin)_

```setup-ssh.ps1
Set-Service ssh-agent -StartupType Automatic
Start-Service ssh-agent
ssh-add "$env:USERPROFILE/.ssh/id_rsa"
```

### 2️⃣ INSTALL CHOCO, GIT, POWERSHELL _(Admin)_

```setup.ps1
iex (iwr "add later").Content
```

### 3️⃣ CLONE REPO

```cloneRepo.ps1
# Clone repo
# git clone --bare "git@github.com:KevinNitroG/KevinNitro-Windows-Dotfiles.git" "$env:USERPROFILE\KevinNitro-Dotfiles"
New-Item -ItemType Directory -Path "$env:USERPROFILE\KevinNitro-Dotfiles"
git init --bare "$env:USERPROFILE\KevinNitro-Dotfiles"
git --git-dir="$env:USERPROFILE/KevinNitro-Dotfiles/" --work-tree="$env:USERPROFILE" branch -m main
git --git-dir="$env:USERPROFILE/KevinNitro-Dotfiles/" --work-tree="$env:USERPROFILE" add backup.txt
git --git-dir="$env:USERPROFILE/KevinNitro-Dotfiles/" --work-tree="$env:USERPROFILE" commit -m "Backup at $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")"
# git --git-dir="$env:USERPROFILE/KevinNitro-Dotfiles/" --work-tree="$env:USERPROFILE" remote set-url --add origin "git@github.com:KevinNitroG/KevinNitro-Windows-Dotfiles.git"
git --git-dir="$env:USERPROFILE/KevinNitro-Dotfiles/" --work-tree="$env:USERPROFILE" branch --set-upstream-to=origin/main main
git --git-dir="$env:USERPROFILE/KevinNitro-Dotfiles/" --work-tree="$env:USERPROFILE" pull origin main
```

### 4️⃣ SET ENV PATH _(Admin)_

```restoreWindows-EnvPath.ps1
& "$env:USERPROFILE\KevinNitro-Dotfiles\KevinNitro-Files\Scripts\Powershell\restoreWindows\restoreWindows-EnvPath.ps1"
```

### 5️⃣ INSTALL POWERSHELL MODULES, CHOCO APPS, OH-MY-POSH _(Admin)_

```installChocoPackages.ps1
& "$env:USERPROFILE\KevinNitro-Dotfiles\KevinNitro-Files\Scripts\Powershell\restoreWindows\restoreWindows-InstallPackages.ps1"
```

### 6️⃣ INSTALL FONTS

sth

### 7 INSTALL SOME CODE STUFF

```.ps1
# prettier
npm install prettier

# ruff
pip intsall ruff

# eslint
npm install eslint

# cpplint
pip install cpplint

# markdownlint
npm install markdownlint

# actionlint
choco install actionlint
```

```.ps1
scoop bucket add extras
scoop install komorebi whkd
# scoop install extras/autohotkey
choco install autohotkey
```

## 🎈 EXTRAS

### Crack Winrar _(Admin)_

Source: https://gist.github.com/MuhammadSaim/de84d1ca59952cf1efaa8c061aab81a1

```crack-winrar.ps1
curl https://gist.githubusercontent.com/MuhammadSaim/de84d1ca59952cf1efaa8c061aab81a1/raw/rarreg.key | Out-File -FilePath "C:\Program Files\WinRAR\rarreg.key" -Force
```

### Patch IDM

```patch-idm.ps1
iex(irm is.gd/idm_reset)
```

### Install & Active Office

https://otp.landian.vip/redirect/download.php?type=runtime&arch=x64&site=github

```active-office.ps1
irm https://massgrave.dev/get | iex
```

### Spictify

```spictify.ps1
& "$env:USERPROFILE\KevinNitro-Files\Scripts\Powershell\spicetifyUpdateScript.ps1"
```

### Others

- [ ] Change ownership of old folders / files
- [ ] Install [Cursor](KevinNitro-Files/Windows-11-Cursor-by-rosea92//dark/regular/01.%20default/Install.inf)
- [ ] [VisualCppRedist AIO](https://github.com/abbodi1406/vcredist/releases/latest/download/VisualCppRedist_AIO_x86_x64.exe)
- [ ] Change `Downloads`, `Desktop`,... location
- [ ] Restore Powertoys settings
- [ ] Chrome flags
- [ ] Spotify `notepad %USERPROFILE%\AppData\Roaming\Spotify\prefs`: `storage.size=500`
- [ ] [iSlide](https://islide-powerpoint.com/en/downloads-en)
- [ ] [3UTools](https://www.3u.com/)
- [ ] [qBittorrent _(qt6)_](https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest)
- [ ] [OBS Background Removal](https://github.com/occ-ai/obs-backgroundremoval/releases/latest)
- [ ] Keystore Explorer
- [ ] Minecraft: [Legacy Launcher](https://llaun.ch/en)
- [ ] MathType
- [ ] Microsoft Teams
- [ ] [MPC - HC](https://github.com/clsid2/mpc-hc)

- [Winaero Tweaker](https://winaerotweaker.com/download/)

  - [ ] Disable Windows Defender
  - [ ] Disable Shortcut Arrow

- [Optimizer](https://github.com/hellzerg/optimizer/releases/latest)

- Wakatime CLI _(Required by Terminal Powershell)_: `pip install wakatime`

- Wakatime for Office

  - https://github.com/wakatime/office-wakatime/releases/download/latest/ExcelSetup.zip
  - https://github.com/wakatime/office-wakatime/releases/download/latest/PowerPointSetup.zip
  - https://github.com/wakatime/office-wakatime/releases/download/latest/WordSetup.zip

- ViveTool

  ```.ps1
  vivetool /disable /id:42354458 # Disable desktop switch animation
  ```

- Windows Settings

  - [ ] Wallpaper: https://github.com/DenverCoder1/minimalistic-wallpaper-collection
  - [ ] Touchpad Gestures _(3 & 4 fingers)_
  - [ ] DNS from NextDNS _(https://router.nextdns.io/?limit=50&stack=dual)_:

    - IPv4:

      - `103.186.65.82`
      - `https://greencloud-sgn-1.edge.nextdns.io/`
      - `38.60.253.211`
      - `https://lightnode-sgn-1.edge.nextdns.io/`

    - IPv6:

      - `2400:6ea0:0:1236::d6e2`
      - `https://greencloud-sgn-1.edge.nextdns.io/`
      - `2606:4700:4700::1111`
      - `https://cloudflare-dns.com/dns-query`

  - Power & Sleep
  - Print Screen button with snipping tool
  - Program shortcut: %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs

## 📒 NOTES

### SSH

Public key

```id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDap/5GnLxYYNJ2QB1rYRgXyHLQud0L3Y6sfiPL6iAdqZRm+f+006DeZtJ4oP2IN8oS6nF6tfWhCaQ91jv3fZWO+olhyBZulSGbb75WdcqLcctfDwc9er+BZZZMBsF0inEbCgHEooo5kelkuuPIEUmeqn9ozUtQ4A6mLIurjsGfy2nD2bCjYys3UxUa09xEiQxvgHnlvSPCh9XvG1h4eX611GI6EbtJoOvzFPYzaxdNosbombq1HMnNGXk3TMS9fghE1GjnMiBbrortGn6mT0aNi//N9Wgr9AYR0dY2BWk1CZXF78G4MWZoaLOLW5sriMjU881UbfmJx6MmvMAEHDrfJDIQAIoRsjAJbw00SoZjspEg3R8f8ekNjduzikG65noMJGd+jTD7MtBDe+YNCuZp6UQAPwbPQLtlbKOysEWzPupKMHIsPkzUJpdYp1ML1ljV/q+FLRKje4FvWUKTk8KekWxp2tUyn5gWUIrG7DGkE5MKpBp0njFJ17n8H81xQJs= trannguyenthaibinh46@gmail.com
```

### GIT

#### Git submodules

- **Add:**

```submodule-add.ps1
df submodule add <url> <location>
```

- **Update:**

```submodule-update.ps1
df submodule foreach git pull origin master
```

#### Tracking files

- **Stop tracking file**

```stopTrackingFile.ps1
df rm --cached <file>
```

- **Stop tracking folder**

```stopTrackingFolder.ps1
df rm -r --cached <folder>
```

- **List all tracked files**

```listAllTrackedFiles.ps1
df ls-tree --full-tree --name-only -r HEAD
```

### POWERSHELL

- **List all modules installed in Powershell**

```getModule.ps1
Get-Module -ListAvailable
```

### WINDOWS

#### View current path

- **System path**

```viewSystemPath.ps1
[System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
```

- **User path**

```viewUserPath.ps1
[System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
```

#### Windows Variables

Source: https://learn.microsoft.com/en-us/windows/deployment/usmt/usmt-recognized-environment-variables

- `%USERPROFILE%`: C:\Users\KevinNitro
- `%HOMEPATH%`: \Users\KevinNitro
- `%APPDATA%`: C:\Users\KevinNitro\AppData\Roaming
- `%LOCALAPPDATA%`: C:\Users\KevinNitro\AppData\Local
- `%PROGRAMDATA%`: C:\ProgramData
- `%PROGRAMFILES%`: C:\Program Files
- `%PROGRAMFILES(X86)%`: C:\Program Files (x86)
- `%SYSTEMROOT%`: C:\Windows
- `%TEMP%` & `%TMP%`: C:\Users\KevinNitro\AppData\Local\Temp
- `%WINDIR%`: C:\Windows
- `%USERDOMAIN%`: DESKTOP-7QJ8Q7V
- `%USERNAME%`: KevinNitro
- `%HOMEDRIVE%`: C:

#### DATETIME FORMAT

https://help.scribesoft.com/scribe/en/sol/general/datetime.htm
