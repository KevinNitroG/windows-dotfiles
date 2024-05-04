function List-BatThemes
{
    $file = fzf --prompt="Select a file to preview  " --preview  "bat --color=always {1} --style=numbers --line-range=:500 {}" --header "Bat preview themes" --header-first
    bat --list-themes | fzf --preview "bat theme={} --color=always $file"
}
