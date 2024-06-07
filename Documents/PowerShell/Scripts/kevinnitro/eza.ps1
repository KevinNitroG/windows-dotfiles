if (!(Get-Command -Name "eza" -ErrorAction SilentlyContinue))
{
  return
}

$DEFAULT_EZA_ARGS = @(
  "--group-directories-first",
  "--ignore-glob=.DS_Store",
  "--icons=always",
  "--colour=always",
  "--sort=type",
  "--git"
)

function _ls
{
  eza -1 @DEFAULT_EZA_ARGS @args
}

function l
{
  eza -lh @DEFAULT_EZA_ARGS @args
}

function ll
{
  eza -lag @DEFAULT_EZA_ARGS @args
}

function ld
{
  eza -lhD @DEFAULT_EZA_ARGS @args
}

function lt
{
  eza --tree @DEFAULT_EZA_ARGS @args
}

Set-Alias -Name ls -Value _ls -Force
