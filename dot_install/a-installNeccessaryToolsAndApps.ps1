Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

choco config set commandExecutionTimeoutSeconds 0

choco instal googlechrome `
  git `
  chezmoi `
  gpg4win `
  powershell-core `
  -y

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
