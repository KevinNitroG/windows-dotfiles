# ensure to have enviroment variable

$directory = "bin/vscode-cpptools"
$url = "https://github.com/microsoft/vscode-cpptools/releases/latest/download/cpptools-win64.vsix"
$tempPath = [System.IO.Path]::Combine($env:TEMP, "cpptools-win64.vsix")

function Update-VscodeCPPTools
{
  if (Test-Path -Path $directory)
  {
    Remove-Item -Path $directory -Recurse -Force
    Write-Host "Old directory removed: $directory"
  }

  Invoke-WebRequest -Uri $url -OutFile $tempPath
  Write-Host "Downloaded archive from $url to $tempPath"

  if (-Not (Test-Path -Path $directory))
  {
    New-Item -Path $directory -ItemType Directory
    Write-Host "Created directory: $directory"
  }

  Expand-Archive -Path $tempPath -DestinationPath $directory

  Remove-Item -Path $tempPath -Force
  Write-Host "Removed archive file: $tempPath"
}
