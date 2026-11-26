$modules = @(
    'PSReadLine'
    'PSFzf'
    'posh-git'
    'Terminal-Icons'
)

Install-Module -Name $modules `
    -Repository PSGallery `
    -Scope CurrentUser `
    -Force
