$modules = @(
    'PSReadLine'
    'PSFzf'
)

Install-Module -Name $modules `
    -Repository PSGallery `
    -Scope CurrentUser `
    -Force
