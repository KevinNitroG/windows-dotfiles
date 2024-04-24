function chtsh
{
    $languages = @(
        "python",
        "cpp",
        "js",
        "ts",
        "bash",
        "powershell",
        "nodejs",
        "lua",
        "css",
        "html"
    )
    $command = @(

    )
    $selected = $languages + $command | fzf --prompt "cht.sh  "  --height=~80% --layout=reverse --border --exit-0 --cycle --margin="2,3" --padding=1
    if (-not $selected)
    {
        exit 0
    }

    $query = Read-Host "Enter Query"

    if ($languages -contains $selected)
    {
        $query = $query -replace ' ', '+'
        curl "cht.sh/$selected/$query"
    } else
    {
        curl "cht.sh/$selected~$query"
    }
}
