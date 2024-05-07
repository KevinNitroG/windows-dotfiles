function _eza
{
  # eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions $args
  eza --long --git --icons=always --color=always --sort="type" $args
}

function ll
{
  _eza -la
}

function la
{
  _eza -a
}

Set-Alias -Name ls -Value _eza
