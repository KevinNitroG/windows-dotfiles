# C:\Users\trann\AppData\Local\spicetify
# C:/ProgramData/chocolatey/lib/spicetify-cli/tools/bin

$SpicetifyPath = spicetify path

function Update-Extension
{
    param(
        [Parameter(Mandatory=$true)]
        [string]$extensionName,
        [Parameter(Mandatory=$true)]
        [string]$extensionURL
    )
    if (Test-Path "$SpicetifyPath/Extensions/$extensionName")
    {
        Remove-Item -Path "$SpicetifyPath/Extensions/$extensionName"
    }
    wget -O "$SpicetifyPath/Extensions/$extensionName" "$extensionURL"
}

# Update spiceify-cli

spicetify.exe update

# Check dir (Themes, extension)exist

if (!(Test-Path "$SpicetifyPath/Extensions"))
{
    New-Item -Path "$SpicetifyPath/Extensions" -ItemType Directory
}

# Update extensions

echo "Update Volume Percentage"
Update-Extension "volumePercentage.js" "https://github.com/daksh2k/Spicetify-stuff/raw/master/Extensions/volumePercentage.js"
echo "Done updating Volume Percentage!"

echo "Update Beautiful Lyrics"
Update-Extension "beautiful-lyrics.js" "https://github.com/surfbryce/beautiful-lyrics/raw/main/dist/beautiful-lyrics.js"
echo "Done updating Beautiful Lyrics!"

echo "Update Adblock"
Update-Extension "adblock.js" "https://github.com/CharlieS1103/spicetify-extensions/raw/main/adblock/adblock.js"
echo "Done updating Adblock!"

echo "Update Auto Skip Video"
Update-Extension "autoSkipVideo.js" "https://raw.githubusercontent.com/spicetify/spicetify-cli/master/Extensions/autoSkipVideo.js"
echo "Done updating Auto Skip Video!"

# Theme update

echo "Update Themes - Catppuccin"
if (Test-Path "$SpicetifyPath/Themes/catppuccin")
{
    Remove-Item -Path "$SpicetifyPath/Themes/catppuccin" -Recurse
}
wget -O "$SpicetifyPath/Themes/catppuccin.zip" "https://codeload.github.com/catppuccin/spicetify/zip/refs/heads/main"
Expand-Archive -Path "$SpicetifyPath/Themes/catppuccin.zip" -DestinationPath "$SpicetifyPath/Themes/catppuccin-extracted"
Move-Item -Path "$SpicetifyPath/Themes/catppuccin-extracted/spicetify-main/catppuccin" -Destination "$SpicetifyPath/Themes/"
Remove-Item -Path "$SpicetifyPath/Themes/catppuccin.zip"
Remove-Item -Path "$SpicetifyPath/Themes/catppuccin-extracted" -Recurse
echo "Done updating Themes - Catppuccin!"

# SPICETIFY APPLY
spicetify.exe apply
