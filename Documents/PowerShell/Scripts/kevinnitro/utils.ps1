function ..
{ Set-Location .\..
}

function ....
{ Set-Location .\..\.. 
}

function List-AvailableModules
{
  Get-Module -ListAvailable
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

function ll
{
  Get-ChildItem -Path $pwd -File
}

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
#     "" | Out-File $file -Encoding ASCII
# }

# function df {
#     get-volume
# }

function sed($file, $find, $replace)
{
    (Get-Content $file).replace("$find", $replace) | Set-Content $file
}

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
  $user    = [Security.Principal.WindowsIdentity]::GetCurrent()
  $isAdmin = (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
  return $isAdmin
}
