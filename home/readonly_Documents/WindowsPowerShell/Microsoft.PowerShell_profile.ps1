# ---------------------------------------------------------------------------------
# PSReadLine
# ---------------------------------------------------------------------------------

Import-Module PSReadLine

# - History
Set-PSReadLineOption -MaximumHistoryCount 10000
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# - General
Set-PSReadLineOption -BellStyle None

# - Autosuggestions
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView

# - Keybindings
Set-PSReadLineKeyHandler -Key RightArrow -Function ForwardChar
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# ---------------------------------------------------------------------------------
# Shell Tools
# ---------------------------------------------------------------------------------

# - PSFzf
Import-Module PSFzf

Set-PsFzfOption `
    -PSReadlineChordProvider 'Ctrl+t' `
    -PSReadlineChordReverseHistory 'Ctrl+r'

# - posh-git
Import-Module posh-git

# - Terminal-Icons
Import-Module Terminal-Icons

# - zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    $env:_ZO_RESOLVE_SYMLINKS = "1"
    Invoke-Expression (zoxide init powershell --cmd cd | Out-String)
}
