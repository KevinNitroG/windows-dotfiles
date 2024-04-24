set PingWebsite=google.com
set LogPath=%APPDATA%\rclone\mount
set LogFile=%LogPath%\log.txt
set RemoteName=CombineNeccessary
set DriveLetter=Z
set CacheDir=%LogPath%\cache
set Counter=0

:CHECK_CONNECTION
ping %PingWebsite% -n 1 > nul
if %errorlevel% neq 0 (
    timeout /t 30 > nul
    set /a Counter+=1
    if %Counter% lss 5 (
        goto CHECK_CONNECTION
    ) else (
        exit 1
    )
)

IF NOT EXIST %LogPath% (
    mkdir %LogPath%
)

IF NOT EXIST %CacheDir% (
    mkdir %CacheDir%
)

del /f /q %LogFile%

start SilentCMD rclone mount ^
    %RemoteName%: %DriveLetter%: ^
    --network-mode ^
    --volname="Cloud Storages" ^
    --no-modtime ^
    --cache-dir=%CacheDir% ^
    --vfs-cache-mode=full ^
    --ignore-checksum ^
    --metadata ^
    --buffer-size=512M ^
    --vfs-cache-max-age=72h ^
    --transfers=8 ^
    --log-file=%LogFile%

timeout /t 2

taskkill /f /im SilentCMD.exe