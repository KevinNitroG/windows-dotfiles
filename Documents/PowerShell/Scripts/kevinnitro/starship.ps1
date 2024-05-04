
function Invoke-Starship-TransientFunction
{
  &starship module character
}

Invoke-Expression (&starship init powershell)

# Enable-TransientPrompt # Disable due to conflict and no use when using with zoxide
