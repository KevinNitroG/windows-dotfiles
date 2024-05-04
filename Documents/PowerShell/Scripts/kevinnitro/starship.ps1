
function Invoke-Starship-TransientFunction
{
  &starship module character
}

Invoke-Expression (&starship init powershell)

Enable-TransientPrompt
