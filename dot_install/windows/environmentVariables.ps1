$USER_PATHS = @(
  "%LOCALAPPDATA%\nvim-data\mason\bin",
  "%USERPROFILE%\.local\bin",
  "%USERPROFILE%\scoop\apps\git\current\usr\bin"
  # "$($env:USERPROFILE)\bin\vscode-cpptools\extension\debugAdapters\bin".
)

# Allow long path
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

function add_paths_to_existed_paths
{
  param (
    [string[]] $paths
  )
  $existedPaths = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User) -split ";"
  $pathToInclude = $existedPaths
  $includePathSet = New-Object System.Collections.Generic.HashSet[[String]]
  foreach ($path in $existedPaths)
  {
    $includePathSet.Add($path) >$null
  }
  foreach ($path in $paths)
  {
    if (!($includePathSet.Contains($path)))
    {
      $pathToInclude += $path
    }
  }
  return $pathToInclude
}

$IncludePaths = (add_paths_to_existed_paths $USER_PATHS) -join ";"

# Hashtable of Variables keys, values
$SetupEnv = @{
  Path = $IncludePaths;
  YAZI_CONFIG_HOME = "%USERPROFILE%\.config\yazi";
  YAZI_FILE_ONE = "%USERPROFILE%\scoop\apps\git\current\usr\bin\file.exe";
  KOMOREBI_CONFIG_HOME = "%USERPROFILE%\.config\komorebi";
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
