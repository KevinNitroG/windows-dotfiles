# ref: https://github.com/ChrisTitusTech/powershell-profile/blob/main/Microsoft.PowerShell_profile.ps1

function ..
{
  Set-Location .\..
}

function ...
{ 
  Set-Location .\..\.. 
}

function .3
{ 
  Set-Location .\..\..\..
}

function .4
{ 
  Set-Location .\..\..\..\..
}

function .5
{ 
  Set-Location .\..\..\..\..\..
}

function List-AvailableModules
{
  Get-Module -ListAvailable
}

function Update-PowerShell
{
  if (-not $global:canConnectToGitHub)
  {
    Write-Host "Skipping PowerShell update check due to GitHub.com not responding within 1 second." -ForegroundColor Yellow
    return
  }

  try
  {
    Write-Host "Checking for PowerShell updates..." -ForegroundColor Cyan
    $updateNeeded = $false
    $currentVersion = $PSVersionTable.PSVersion.ToString()
    $gitHubApiUrl = "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"
    $latestReleaseInfo = Invoke-RestMethod -Uri $gitHubApiUrl
    $latestVersion = $latestReleaseInfo.tag_name.Trim('v')
    if ($currentVersion -lt $latestVersion)
    {
      $updateNeeded = $true
    }

    if ($updateNeeded)
    {
      Write-Host "Updating PowerShell..." -ForegroundColor Yellow
      winget upgrade "Microsoft.PowerShell" --accept-source-agreements --accept-package-agreements
      Write-Host "PowerShell has been updated. Please restart your shell to reflect changes" -ForegroundColor Magenta
    } else
    {
      Write-Host "Your PowerShell is up to date." -ForegroundColor Green
    }
  } catch
  {
    Write-Error "Failed to update PowerShell. Error: $_"
  }
}

Function Test-CommandExists
{
  Param ($command)
  $oldPreference = $ErrorActionPreference
  $ErrorActionPreference = 'SilentlyContinue'
  try
  { if (Get-Command $command)
    { RETURN $true 
    } 
  } Catch
  { Write-Host "$command does not exist"; RETURN $false 
  } Finally
  { $ErrorActionPreference = $oldPreference 
  }
}

if (Test-CommandExists nvim)
{
  if (Test-Path "$env:LOCALAPPDATA/$env:DEFAULT_NVIM_CONFIG" -PathType Container)
  {
    $env:NVIM_APPNAME = $env:DEFAULT_NVIM_CONFIG
  }
  $EDITOR='nvim'
} elseif (Test-CommandExists code)
{
  $EDITOR='code'
} elseif (Test-CommandExists notepad)
{
  $EDITOR='notepad'
} elseif (Test-CommandExists pvim)
{
  $EDITOR='pvim'
} elseif (Test-CommandExists vim)
{
  $EDITOR='vim'
} elseif (Test-CommandExists vi)
{
  $EDITOR='vi'
} elseif (Test-CommandExists notepad++)
{
  $EDITOR='notepad++'
} elseif (Test-CommandExists sublime_text)
{
  $EDITOR='sublime_text'
}
Set-Alias -Name v -Value $EDITOR

function Edit-Profile
{
  if ($host.Name -match "ise")
  {
    # $psISE.CurrentPowerShellTab.Files.Add($profile.CurrentUserAllHosts)
    $psISE.CurrentPowerShellTab.Files.Add($profile)
  } else
  {
    # notepad $profile.CurrentUserAllHosts
    v $profile
  }
}

# function ll
# {
#   Get-ChildItem -Path $pwd -File
# }

function Get-PubIP
{
    (Invoke-WebRequest http://ifconfig.me/ip ).Content
}

function _Get-Uptime
{
  $bootuptime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
  $CurrentDate = Get-Date
  $uptime = $CurrentDate - $bootuptime
  Write-Output "Uptime: $($uptime.Days) Days, $($uptime.Hours) Hours, $($uptime.Minutes) Minutes"
}

function uptime
{
  #Windows Powershell only
  If ($PSVersionTable.PSVersion.Major -eq 5 )
  {
    Get-WmiObject win32_operatingsystem |
      Select-Object @{EXPRESSION={ $_.ConverttoDateTime($_.lastbootuptime)}} | Format-Table -HideTableHeaders
  } Else
  {
    _Get-Uptime
    net statistics workstation | Select-String "since" | foreach-object {$_.ToString().Replace('Statistics since ', 'Since: ')}
  }
}

function Reload-Profile
{
  . $PROFILE
}

Set-Alias -Name rl -Value Reload-Profile

function find-file($name)
{
  Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
    $place_path = $_.directory
    Write-Output "${place_path}\${_}"
  }
}

function unzip ($file)
{
  Write-Output("Extracting", $file, "to", $pwd)
  $fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object { $_.FullName }
  Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function hb
{
  if ($args.Length -eq 0)
  {
    Write-Error "No file path specified."
    return
  }
    
  $FilePath = $args[0]
    
  if (Test-Path $FilePath)
  {
    $Content = Get-Content $FilePath -Raw
  } else
  {
    Write-Error "File path does not exist."
    return
  }
    
  $uri = "http://bin.christitus.com/documents"
  try
  {
    $response = Invoke-RestMethod -Uri $uri -Method Post -Body $Content -ErrorAction Stop
    $hasteKey = $response.key
    $url = "http://bin.christitus.com/$hasteKey"
    Write-Output $url
  } catch
  {
    Write-Error "Failed to upload the document. Error: $_"
  }
}

function head
{
  param($Path, $n = 10)
  Get-Content $Path -Head $n
}

function tail
{
  param($Path, $n = 10)
  Get-Content $Path -Tail $n
}

function mkcd
{
  param($dir) mkdir $dir -Force; Set-Location $dir 
}

# Quick Access to System Information
function sysinfo
{
  Get-ComputerInfo 
}

# Networking Utilities
function flushdns
{
  Clear-DnsClientCache 
}

# Clipboard Utilities
function cpy
{
  Set-Clipboard $args[0] 
}

function pst
{
  Get-Clipboard 
}

function ix ($file)
{
  curl.exe -F "f:1=@$file" ix.io
}

# function grep($regex, $dir)
# {
#     if ( $dir )
#     {
#         Get-ChildItem $dir | select-string $regex
#         return
#     }
#     $input | select-string $regex
# }

# function touch($file)
# {
#   "" | Out-File $file -Encoding ASCII
# }

function df
{
  get-volume
}

# function sed($file, $find, $replace)
# {
#     (Get-Content $file).replace("$find", $replace) | Set-Content $file
# }

# function which($name) {
#     Get-Command $name | Select-Object -ExpandProperty Definition
# }

function export($name, $value)
{
  set-item -force -path "env:$name" -value $value;
}

function pkill($name)
{
  Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name)
{
  Get-Process $name
}

# Powwershell profile from https://github.com/craftzdog/dotfiles-public/blob/master/.config/powershell/user_profile.ps1

[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

function which ($command)
{
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function Check-IsAdmin
{
  return ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# function Reboot-BIOS
# {
#   if (Check-IsAdmin)
#   {
#     shutdown /r /fw /f /t 0
#   } else
#   {
#     if (Test-CommandExists sudo)
#     {
#       sudo shutdown /r /fw /f /t 0
#     } else
#     Write-Host "Please run with administrator privilege"
#   }
# }
#
function Reboot-BIOS
{
  Start-Process -FilePath "shutdown" -ArgumentList "/r /fw /f /t 0"
}

# Ref: https://gist.github.com/mikepruett3/7ca6518051383ee14f9cf8ae63ba18a7
function extract
{
  param (
    [string]$File,
    [string]$Folder
  )

  if (-not $Folder)
  {
    $FileName = [System.IO.Path]::GetFileNameWithoutExtension($File)
    $Folder = Join-Path -Path (Split-Path -Path $File -Parent) -ChildPath "$FileName"
  }

  if (-not (Test-Path -Path $Folder -PathType Container))
  {
    New-Item -Path $Folder -ItemType Directory | Out-Null
  }

  if (Test-Path -Path "$File" -PathType Leaf)
  {
    switch ($File.Split(".") | Select-Object -Last 1)
    {
      "rar"
      { Start-Process -FilePath "UnRar.exe" -ArgumentList "x","-op'$Folder'","-y","$File" -WorkingDirectory "$Env:ProgramFiles\WinRAR\" -Wait | Out-Null 
      }
      "zip"
      { 7z x -o"$Folder" -y "$File" | Out-Null 
      }
      "7z"
      { 7z x -o"$Folder" -y "$File" | Out-Null 
      }
      "exe"
      { 7z x -o"$Folder" -y "$File" | Out-Null 
      }
      Default
      { Write-Error "No way to Extract $File !!!"; return;
      }
    }
    Write-Host "Extracted "$FILE" to "$($Folder)""
  }
}

function extract_multi
{
  $CurrentDate = (Get-Date).ToString("yyyy-MM-dd_HH-mm-ss")
  $Folder = "extracted_$($CurrentDate)"
  New-Item -Path $Folder -ItemType Directory | Out-Null
  foreach($File in $args)
  {
    extract -File $File -Folder "$($Folder)\$([System.IO.Path]::GetFileNameWithoutExtension($File))"
  }
}
