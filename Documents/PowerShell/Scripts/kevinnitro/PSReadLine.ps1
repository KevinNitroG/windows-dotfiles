Import-Module Catppuccin

$Flavor = $Catppuccin['Mocha']

$ScriptBlock = {
  Param([string]$line)
  if ($line -like " *")
  {return $false
  }
  $ignore_psreadline = @("user", "pass", "account")
  foreach ($ignore in $ignore_psreadline)
  {
    if ($line -match $ignore)
    {
      return $false
    }
  }
  return $true
}

# Ref: https://github.com/catppuccin/powershell#profile-usage
$Colors = @{
  # Largely based on the Code Editor style guide
  # Emphasis, ListPrediction and ListPredictionSelected are inspired by the Catppuccin fzf theme
	
  # Powershell colours
  ContinuationPrompt     = $Flavor.Teal.Foreground()
  Emphasis               = $Flavor.Red.Foreground()
  Selection              = $Flavor.Surface0.Background()
	
  # PSReadLine prediction colours
  InlinePrediction       = $Flavor.Overlay0.Foreground()
  ListPrediction         = $Flavor.Mauve.Foreground()
  ListPredictionSelected = $Flavor.Surface0.Background()

  # Syntax highlighting
  Command                = $Flavor.Blue.Foreground()
  Comment                = $Flavor.Overlay0.Foreground()
  Default                = $Flavor.Text.Foreground()
  Error                  = $Flavor.Red.Foreground()
  Keyword                = $Flavor.Mauve.Foreground()
  Member                 = $Flavor.Rosewater.Foreground()
  Number                 = $Flavor.Peach.Foreground()
  Operator               = $Flavor.Sky.Foreground()
  Parameter              = $Flavor.Pink.Foreground()
  String                 = $Flavor.Green.Foreground()
  Type                   = $Flavor.Yellow.Foreground()
  Variable               = $Flavor.Lavender.Foreground()
}

$PSReadLineOptions = @{
  EditMode = "Windows"
  AddToHistoryHandler = $ScriptBlock
  Color = $Colors
  ExtraPromptLineCount = $true
  HistoryNoDuplicates = $true
  MaximumHistoryCount = 5000
  PredictionSource = "HistoryAndPlugin"
  PredictionViewStyle = "ListView"
  ShowToolTips = $true
  BellStyle = "None"
}

Set-PSReadLineOption @PSReadLineOptions

# VIM MODE

# function OnViModeChange
# {
#   if ($args[0] -eq 'Command')
#   {
#     # Set the cursor to a blinking block.
#     Write-Host -NoNewLine "`e[1 q"
#   } else
#   {
#     # Set the cursor to a blinking line.
#     Write-Host -NoNewLine "`e[5 q"
#   }
# }

# Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

# Set jk to exit vi
# Ref: https://github.com/PowerShell/PSReadLine/issues/1701#issuecomment-1445137723
# Set-PSReadLineKeyHandler -Key j -ViMode Insert -ScriptBlock {
#   if (!$j_timer.IsRunning -or $j_timer.ElapsedMilliseconds -gt 1000)
#   {
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert("k")
#     $j_timer.Restart()
#     return
#   }

#   [Microsoft.PowerShell.PSConsoleReadLine]::Insert("k")
#   [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
#   $line = $null
#   $cursor = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
#   [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor-1, 2)
#   [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor-2)
# }

# ref: https://github.com/PowerShell/PSReadLine/issues/759#issuecomment-518363364
# $j_timer = New-Object System.Diagnostics.Stopwatch
# Set-PSReadLineKeyHandler -Chord 'j' -ScriptBlock {
#   if ([Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode())
#   {
#     $j_timer.ReStart()
#     $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
#     # $key = [System.Console]::ReadKey()
#     if (($j_timer.ElapsedMilliseconds -lt 500) -and $key.Character -eq 'k')
#     {
#       [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
#     } else
#     {
#       [Microsoft.Powershell.PSConsoleReadLine]::Insert('j')
#       [Microsoft.Powershell.PSConsoleReadLine]::Insert($key.Character)
#     }
#     $j_timer.Stop()
#   }
# }

Set-PSReadLineKeyHandler -Key "Ctrl+p" -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key "Ctrl+n" -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key "Ctrl+w" -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
Set-PSReadLineKeyHandler -Key "Ctrl+b" -Function BackwardWord

# https://ianmorozoff.com/2023/01/10/predictive-intellisense-on-by-default-in-powershell-7-3/#keybinding
$parameters = @{
  Key = 'F4'
  BriefDescription = 'Toggle PSReadLineOption PredictionSource'
  LongDescription = 'Toggles the PSReadLineOption PredictionSource option between "None" and "HistoryAndPlugin".'
  ScriptBlock = {

    # Get current state of PredictionSource
    $state = (Get-PSReadLineOption).PredictionSource

    # Toggle between None and HistoryAndPlugin
    switch ($state)
    {
      "None"
      {Set-PSReadLineOption -PredictionSource HistoryAndPlugin
      } 
      "History"
      {Set-PSReadLineOption -PredictionSource None
      }
      "Plugin"
      {Set-PSReadLineOption -PredictionSource None
      }
      "HistoryAndPlugin"
      {Set-PSReadLineOption -PredictionSource None
      }
      Default
      {Write-Host "Current PSReadLineOption PredictionSource is Unknown"
      }
    }

    # Trigger autocomplete to appear without changing the line
    # InvokePrompt() does not cause ListView style suggestions to disappear when toggling off
    #[Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()

    # Trigger autocomplete to appear or disappear while preserving the current input
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert(' ')
    [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteChar()

  }
}
Set-PSReadLineKeyHandler @parameters

# Clear PSReadLine history
function Clear-PSReadLineHistory
{
  Get-PSReadlineOption | Select-Object -expand HistorySavePath | Remove-Item
}
