$USER_PATHS = @(
  "$($env:LOCALAPPDATA)\Local\SilentCMD",
  "C:\Users\kevinnitro\AppData\Local\nvim-data\mason\bin"
  # "$($env:USERPROFILE)\bin\vscode-cpptools\extension\debugAdapters\bin".
  # "D:\My Apps\ENV Tools\vcpkg",
  # "C:\Program Files\OpenSSL-Win64\bin",
)

# Allow long path
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

# function Test-PathExistList
# {
#   param (
#     [string[]] $Paths
#   )
#   $ExistedPaths = @()
#   foreach ($Path in $Paths)
#   {
#     if (Test-Path -Path $Path -ErrorAction SilentlyContinue)
#     {
#       $ExistedPaths += $Paths
#     }
#   }
#   return $ExistedPaths
# }

# Process include paths, avoid already included paths
# $USER_PATHS = Test-PathExistList($USER_PATHS)
#
$ExistedPaths = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User) -split ";"
$IncludePathSet = New-Object System.Collections.Generic.HashSet[[String]]
foreach ($app in ($USER_PATHS + $ExistedPaths))
{
  $IncludePathSet.Add($app) >$null
}
$IncludePath = ($IncludePathSet -split ",") -join ";"

# Hashtable of Variables keys, values
$SetupEnv = @{
  Path = $IncludePath;
  YAZI_CONFIG_HOME = "$($env:USERPROFILE)\.config\yazi";
  YAZI_FILE_ONE = "$($env:USERPROFILE)\\scoop\apps\git\current\usr\bin\file.exe";
  KOMOREBI_CONFIG_HOME = "$($env:USERPROFILE)\.config\komorebi";
  CARGO_HOME = "E:\packages\cargo";
  npm_config_cache = "E:\cache\npm";
  PIP_CACHE_DIR = "E:\cache\pip";
  VCPKG_BINARY_CACHE = "E:\packages\vcpkg"
  # ZF_DEFAULT_OPTS = "--height=~80% --layout=reverse --border --exit-0 --cycle --margin=2,40 --padding=1"
}

foreach ($Key in $SetupEnv)
{
  [System.Environment]::SetEnvironmentVariable($Key, $SetupEnv[$Key], [System.EnvironmentVariableTarget]::User)
}
