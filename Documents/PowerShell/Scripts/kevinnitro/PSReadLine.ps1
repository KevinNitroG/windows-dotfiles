$ScriptBlock = {
    Param([string]$line)
    $ignore_psreadline = @("user", "pass", "account")
    foreach ( $ignore in $ignore_psreadline )
    {
        if ( $line -match $ignore )
        {
            return $false
        }
    }
    return $true
}

$PSReadLineOptions = @{
    PredictionSource = "HistoryAndPlugin"
    PredictionViewStyle = "ListView"
    EditMode = "Windows"
    ShowToolTips = $true
    ExtraPromptLineCount = $true
    AddToHistoryHandler = $ScriptBlock
}

Set-PSReadLineOption @PSReadLineOptions

Set-PSReadLineKeyHandler -Key "Ctrl+p" -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key "Ctrl+n" -Function HistorySearchForward


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
