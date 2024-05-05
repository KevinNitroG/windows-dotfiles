# Get the current value of the Path variable (User)
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

# Allow long path
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

# Define multiple paths as an array
$newPaths = @(
  "D:\My Apps\ENV Tools\OCI CLI\bin",
  "$env:LOCALAPPDATA\Local\SilentCMD",
  "D:\My Apps\ENV Tools\Koyeb CLI",
  "D:\My Apps\ENV Tools\Solution Merge",
  "D:\My Apps\ENV Tools\MinGW x64\bin",
  "D:\My Apps\ENV Tools\vcpkg",
  "D:\My Apps\ENV Tools\goodbyedpi"
  "C:\Program Files\OpenSSL-Win64\bin"
)

# Join paths with a newline character
$newPathsString = $newPaths -join ";"

# Set the updated Path variable (User)
[System.Environment]::SetEnvironmentVariable("Path", "$currentPath;$newPathsString", [System.EnvironmentVariableTarget]::User)


# ENV

# Cargo
setx /M CARGO_HOME "E:\packages\cargo"

# NPM config cache
setx /M npm_config_cache "E:\cache\npm"

# Python Pip cache
setx /M PIP_CACHE_DIR "E:\cache\pip"

# VCPKG binary cache
setx /M VCPKG_BINARY_CACHE "E:\packages\vcpkg"

# Komorebi
setx /M KOMOREBI_CONFIG_HOME "$env:USERPROFILE\.config\komorebi"

# FZF DEFAULT OPTS
# setx FZF_DEFAULT_OPTS  "--height=~80% --layout=reverse --border --exit-0 --cycle --margin=2,40 --padding=1"
