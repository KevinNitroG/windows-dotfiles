# Function to trigger komorebi

function Start-Komorebi 
{
  if (! (Get-Process "komorebi" -ErrorAction SilentlyContinue))
  {
    komorebic.exe start  
  }
  if (! (Get-Process "AutoHotKey" -ErrorAction SilentlyContinue))
  {
    # AutoHotkey.exe "C:/Users/kevinnitro/.config/komorebi/komorebi.ahk"
    AutoHotkey.exe "C:/Users/kevinnitro/.config/autohotkey.ahk"
  }
}

# Update applications.yml

function Update-KomorebiApplications
{
  komorebic fetch-asc
}
