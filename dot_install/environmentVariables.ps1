$USER_PATHS = @(
  "D:\My Apps\ENV Tools\OCI CLI\bin",
  "$env:LOCALAPPDATA\Local\SilentCMD",
  "D:\My Apps\ENV Tools\Koyeb CLI",
  "D:\My Apps\ENV Tools\Solution Merge",
  "D:\My Apps\ENV Tools\MinGW x64\bin",
  "D:\My Apps\ENV Tools\vcpkg",
  "D:\My Apps\ENV Tools\goodbyedpi"
  "C:\Program Files\OpenSSL-Win64\bin"
)

# Allow long path
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

$SetupEnv = @{
  Path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User) + (($USER_PATHS) -join ";");
  YAZI_CONFIG_HOME = "$($env:USERPROFILE)\.config\yazi";
  KOMOREBI_CONFIG_HOME = "$($env:USERPROFILE)\.config\komorebi";
  CARGO_HOME = "E:\packages\cargo";
  npm_config_cache = "E:\cache\npm";
  PIP_CACHE_DIR = "E:\cache\pip";
  VCPKG_BINARY_CACHE = "E:\packages\vcpkg"
}

foreach ($Key in $SetupEnv)
{
  [System.Environment]::SetEnvironmentVariable($Key, $SetupEnv[$Key], [System.EnvironmentVariableTarget]::User)
}

# FZF DEFAULT OPTS
# setx FZF_DEFAULT_OPTS  "--height=~80% --layout=reverse --border --exit-0 --cycle --margin=2,40 --padding=1"
