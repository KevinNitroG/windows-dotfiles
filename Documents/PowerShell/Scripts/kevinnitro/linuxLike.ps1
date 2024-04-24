# FROM https://github.com/ChrisTitusTech/powershell-profile/
# If so and the current host is a command line, then change to red color 
# as warning to user that they are operating in an elevated context
# Useful shortcuts for traversing directories
# Compute file hashes - useful for checking successful downloads 

function md5
{ Get-FileHash -Algorithm MD5 $args 
}
function sha1
{ Get-FileHash -Algorithm SHA1 $args 
}
function sha256
{ Get-FileHash -Algorithm SHA256 $args 
}

# Quick shortcut to start notepad
function n
{ notepad $args 
}

# Drive shortcuts
function HKLM:
{ Set-Location HKLM: 
}
function HKCU:
{ Set-Location HKCU: 
}
function Env:
{ Set-Location Env: 
}

# Does the the rough equivalent of dir /s /b. For example, dirs *.png is dir /s /b *.png
function dirs
{
  if ($args.Count -gt 0)
  {
    Get-ChildItem -Recurse -Include "$args" | Foreach-Object FullName
  } else
  {
    Get-ChildItem -Recurse | Foreach-Object FullName
  }
}

