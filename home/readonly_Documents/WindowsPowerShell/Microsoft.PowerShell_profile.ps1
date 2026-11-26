# ---------------------------------------------------------------------------------
# Environment
# ---------------------------------------------------------------------------------

# - Editor
if (Get-Command zed -ErrorAction SilentlyContinue) {
    $env:EDITOR = "zed --wait"
    $env:VISUAL = $env:EDITOR
}

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

# - PSFzf
Import-Module PSFzf

Set-PsFzfOption `
    -PSReadlineChordReverseHistory 'Ctrl+r' `
    -EnableAliasFuzzyEdit `
    -EnableAliasFuzzyGitStatus `
    -EnableAliasFuzzyKillProcess

# - zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    $env:_ZO_RESOLVE_SYMLINKS = "1"
    Invoke-Expression (zoxide init powershell --cmd cd | Out-String)
}

# - Starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}
