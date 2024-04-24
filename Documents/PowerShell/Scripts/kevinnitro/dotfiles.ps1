function df
{
    git --git-dir=$env:USERPROFILE/KevinNitro-Dotfiles/ --work-tree=$env:USERPROFILE $args
}

function dfs
{
    # df pull
    Set-Location
    # df submodule update --init --recursive --remote --rebase
    df add -u
    df commit -m "$(Get-Date -Format 'h:mm tt on d/M/y')"
    df push
}

function dfa
{
    Set-Location
    df add $args
}

function df-submodule-update
{
    Set-Location
    df submodule update --init --recursive --remote --rebase
}
