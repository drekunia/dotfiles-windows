# ---------------------------------------------------------------------------------
# PSReadLine
# ---------------------------------------------------------------------------------

Import-Module PSReadLine

# - History
Set-PSReadLineOption -MaximumHistoryCount 10000
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -BellStyle None

# - Autosuggestions
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView

# - Autosuggestion keybindings
Set-PSReadLineKeyHandler -Key RightArrow -Function ForwardChar
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord

# - History search
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory

# - Completion
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# ---------------------------------------------------------------------------------
# Directory Navigation
# ---------------------------------------------------------------------------------

function ..     { Set-Location .. }
function ...    { Set-Location ../.. }
function ....   { Set-Location ../../.. }
function .....  { Set-Location ../../../.. }

# ---------------------------------------------------------------------------------

# - zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    $env:_ZO_RESOLVE_SYMLINKS = "1"

    Invoke-Expression (& {
        zoxide init powershell --cmd cd | Out-String
    })
}
