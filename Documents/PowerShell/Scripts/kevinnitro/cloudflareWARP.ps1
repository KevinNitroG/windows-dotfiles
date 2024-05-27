$CLOUDFLAREWARP_SERVICE_NAME = "CloudflareWARP"

function Start-CloudFlareWarp
{
  $sv = Get-Service -Name $CLOUDFLAREWARP_SERVICE_NAME -ErrorAction SilentlyContinue
  if ($sv)
  {
    Set-Service -Name $CLOUDFLAREWARP_SERVICE_NAME -StartupType Automatic
    Set-Service -Name $CLOUDFLAREWARP_SERVICE_NAME -Status Running -PassThru
    & "Cloudflare WARP.exe"
    Write-Host "Started CloudflareWARP"
  } else
  {
    Write-Error "No CloudflareWARP service found!"
  }
}

function Stop-CloudFlareWarp 
{
  $sv = Get-Service -Name CloudflareWARP -ErrorAction SilentlyContinue
  if ($sv)
  {
    Set-Service -Name $CLOUDFLAREWARP_SERVICE_NAME -StartupType Disabled
    Set-Service -Name $CLOUDFLAREWARP_SERVICE_NAME -Status Stopped -PassThru
    Stop-Process -Name "Cloudflare WARP" -Force -ErrorAction SilentlyContinue
    Write-Host "Stopped CloudflareWARP"
  } else
  {
    Write-Error "No CloudflareWARP service found!"
  }
}

