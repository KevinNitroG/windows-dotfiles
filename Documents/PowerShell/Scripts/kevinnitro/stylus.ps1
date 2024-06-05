# Update catppuccin stylus themes

function Update-CatppuccinStylus
{
  $url = "https://github.com/catppuccin/userstyles/releases/download/all-userstyles-export/import.json"
  $file = "$env:USERPROFILE\.config\stylus\catppuccin.json"

  Invoke-WebRequest -Uri $url -OutFile $file

  $content = Get-Content -Path $file -Raw
  $updatedContent = $content -replace '"name":"accentColor","value":null', '"name":"accentColor","value":"lavender"'

  Set-Content -Path $file -Value $updatedContent
}
