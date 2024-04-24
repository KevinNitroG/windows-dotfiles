function Check-WiFiPassword
{
    param(
        [string]$name = $null
    )
    if (-not $name)
    {
        if (Get-Command fzf)
        {
            $name = netsh wlan show profiles |
                Select-String -Pattern "All User Profile\s+:\s+(.*)" |
                ForEach-Object { $_.Matches.Groups[1].Value } |
                fzf --prompt="Select Wi-Fi  " --height=~80% --layout=reverse --border --exit-0 --cycle --margin="2,40" --padding=1
        } else
        {
            "LIST OF SAVED WI-FI"
            "`n---`n"
            # Get the list of saved Wi-Fi networks with position numbers
            $wifiList = netsh wlan show profiles |
                Select-String -Pattern "All User Profile\s+:\s+(.*)" |
                ForEach-Object { $_.Matches.Groups[1].Value }
            # Output the list with position numbers
            for ($i=0; $i -lt $wifiList.Count; $i++)
            {
                # "$($i+1): $($wifiList[$i])"
                "{0,5}: {1}" -f ($i+1), $wifiList[$i]
            }
            "`n---`n"
            $inputPosition = Read-Host "Enter the position number of the Wi-Fi network to check the password (Enter for current network)"
            if ([string]::IsNullOrEmpty($inputPosition))
            {
                $name = ((netsh wlan show interfaces | Select-String -Pattern "Profile" -Context 0,1) -split ":")[1].Trim()
            } else
            {
                # Convert the input position to zero-based index
                $index = [int]$inputPosition - 1
                if ($index -ge 0 -and $index -lt $wifiList.Count)
                {
                    $name = $wifiList[$index]
                } else
                {
                    "Invalid position number."
                    return
                }
            }
        }
    }
    if (-not $name)
    {
        "No input Wi-Fi name"
        return
    }
    $wlan_profile = netsh wlan show profile name="$name" key=clear
    $password = $wlan_profile | Select-String -Pattern "Key Content\s+:\s+(.+)" | ForEach-Object { $_.Matches.Groups[1].Value }
    "Wi-Fi: $name"
    if ($password)
    {
        "Password: $password"
    } else
    {
        "No password available"
    }
}
