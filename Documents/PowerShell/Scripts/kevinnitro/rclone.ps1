
if (!(Get-Command -Name "rclone" -ErrorAction SilentlyContinue))
{
  Invoke-Expression (& { (rclone completion powershell | Out-String) })
}
