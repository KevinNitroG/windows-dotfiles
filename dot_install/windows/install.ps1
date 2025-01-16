# Ref: https://gist.github.com/mikepruett3/7ca6518051383ee14f9cf8ae63ba18a7

Write-Host "PLEASE RUN THIS WITH NON ADMINISTRATOR PRIVILEGES!!!"
Pause

Write-Host "INSTALL PREQUISITE SCOOP..."
Invoke-WebRequest "https://raw.githubusercontent.com/KevinNitroG/dotfiles/main/dot_install/windows/prerequisiteScoop.ps1" | Invoke-Expression

Write-Host "INSTALL PREQUISITE CHOCO..."
curl "https://raw.githubusercontent.com/KevinNitroG/dotfiles/main/dot_install/windows/prerequisiteChoco.ps1" -o "$($env:TEMP)\install_prequisite_choco.ps1"
Start-Process -filepath "powershell" -Argumentlist "$($env:TEMP)\install_prequisite_choco.ps1" -Verb runas -Wait remove-item -Path "$($env:TEMP)\install_prequisite_choco.ps1" -Force

Write-Host "APPLY CHEZMOI DOTFILES..."
chezmoi init --apply --verbose git@github.com:KevinNitroG/dotfiles.git

Write-Host "SETUP ENVIRONMENT VARIABLES..."
curl "https://raw.githubusercontent.com/kevinnitrog/dotfiles/main/dot_install/windows/environmentVariables.ps1" -o "$($env:TEMP)\install_environment_variables.ps1"
Start-Process -filepath "powershell" -Argumentlist "$($env:TEMP)\install_environment_variables.ps1" -Verb runas -Wait remove-item -Path "$($env:TEMP)\install_environment_variables.ps1" -Force

Write-Host "INSTALL PROGRAMMING LANGUAGES..."
Invoke-WebRequest "https://raw.githubusercontent.com/KevinNitroG/dotfiles/main/dot_install/windows/programmingLanguage.ps1" | Invoke-Expression

Write-Host "INSTALL APPS WITH NON ADMINISTRATOR PRIVILEGES (SCOOP, NPM, PIP)..."
Invoke-WebRequest "https://raw.githubusercontent.com/KevinNitroG/dotfiles/main/dot_install/windows/softwares-nonadmin.ps1" | Invoke-Expression

Write-Host "INSTALL APPS WITH ADMINISTRATOR PRIVILEGES (CHOCO)..."
curl "https://raw.githubusercontent.com/kevinnitrog/dotfiles/main/dot_install/windows/softwares-admin.ps1" -o "$($env:TEMP)\install_softwares_admin.ps1"
Start-Process -Filepath "powershell" -Argumentlist "$($env:TEMP)\install_softwares_admin.ps1" -Verb runas -Wait remove-item -Path "$($env:TEMP)\install_softwares_admin.ps1" -Force

Write-Host "INSTALL CODING STUFF..."
Invoke-WebRequest "https://raw.githubusercontent.com/KevinNitroG/dotfiles/main/dot_install/windows/codingStuff.ps1" | Invoke-Expression

if (Get-Command -Name bat -ErrorAction SilentlyContinue)
{
  Write-Host "BUILD BAT THEMES..."
  bat cache --build
} else
{
  Write-Host "Bat not installed, skip building Bat themes!"
}

Write-Host "Apply register to associate JAR filetype to be opened with javaw.exe"
reg import $env:USERPROFILE\.scripts\registry\associate_scoop_jar.reg
