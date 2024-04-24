$NVIM_CONFIGS = $env:NVIM_CONFIGS.Split(" ")

function vs
{
    $items = @( "default" ) + $NVIM_CONFIGS
    # $config = $items | Out-GridView -Title "Neovim Config" -OutputMode Single
    $config = $items | fzf --prompt="  Neovim Config  " --height=~80% --layout=reverse --border --exit-0 --cycle --margin="2,40" --padding=1
    if (-not $config)
    {
        Write-Host "No Neovim config was selected"
        return
    } elseif ($config -eq "default")
    {
        $env:NVIM_APPNAME = $env:DEFAULT_NVIM_CONFIG
    } else
    {
        $env:NVIM_APPNAME = $config
    }
    nvim @args
}

function Delete-NeovimData
{
    $available_data =  @("shada", "swap", "undo", "sessions")
    $available_config_and_all = $NVIM_CONFIGS + "all"
    $available_data_and_all = $available_data + "all"
    $user_select_data = $available_data_and_all | fzf --prompt="Delete Neovim Data  " --height=~80% --layout=reverse --border --exit-0 --cycle --margin="2,40" --padding=1
    $user_select_config = $available_config_and_all | fzf --prompt="Choose Neovim Config  " --height=~80% --layout=reverse --border --exit-0 --cycle --margin="2,40" --padding=1
    if ($user_select_data -eq "all")
    {
        $data = $available_data
    } else 
    {
        $data = @($user_select_data) 
    }
    if ($user_select_config -eq "all")
    {
        $configs = $NVIM_CONFIGS
    } else 
    {
        $configs = @($user_select_config) 
    }
    foreach ($config in $configs)
    {
        foreach ($data in $user_select_data)
        {
            if (Test-Path "$env:LOCALAPPDATA/$config-data/$data" -PathType Container)
            {
                Write-Output "Deleting `"$env:LOCALAPPDATA/$config-data/$data`""
                Remove-Item -Path "$env:LOCALAPPDATA/$config-data/$data" -Recurse -Force -ErrorAction Continue
            } else
            {
                Write-Output "`"$env:LOCALAPPDATA/$config-data/$data`" doesn't exist"
            }
        }
    }
}
