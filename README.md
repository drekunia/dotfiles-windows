# Windows Dotfiles

My personal Windows configuration files, managed with [chezmoi](https://www.chezmoi.io/).

For my Linux/WSL configuration, see [`.dotfiles`](https://github.com/drekunia/.dotfiles).

## Setup

### Install dependencies

Run from an elevated PowerShell session:

```powershell
choco install git chezmoi zoxide -y
```

Restart PowerShell as a regular user and configure the execution policy:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Configure chezmoi

Create the chezmoi configuration directory:

```powershell
New-Item -ItemType Directory -Path "$HOME\.config\chezmoi" -Force
notepad "$HOME\.config\chezmoi\chezmoi.toml"
```

Add the following configuration, replacing `<username>` with your Windows username:

```toml
sourceDir = "C:/Users/<username>/.dotfiles-windows"
```

### Initialize dotfiles

```powershell
chezmoi init https://github.com/drekunia/.dotfiles-windows.git

cd "$HOME\.dotfiles-windows"
```

### Install PowerShell modules and configure Windows

```powershell
.\scripts\windows-settings.ps1
.\scripts\install-modules.ps1
```

### Apply configuration

Preview the changes before applying them:

```powershell
chezmoi diff
chezmoi apply --dry-run --verbose
chezmoi apply
```

Restart the terminal.

### Fonts

Install [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads) if required by the Windows Terminal configuration.

Review machine-specific paths and terminal profiles after restoring the configuration.

## Packages

The package manifests are snapshots of installed applications, rather than curated installation lists. They may contain overlapping applications and should be reviewed before restoration.

Run the following commands from the repository root:

```powershell
cd "$HOME\.dotfiles-windows"
```

### Restore Chocolatey packages

Run from an elevated PowerShell session:

```powershell
choco install .\windows\choco.config -y
```

### Restore WinGet packages

```powershell
winget import --import-file .\windows\winget.json --ignore-unavailable
```

### Export package lists

```powershell
choco export .\windows\choco.config
winget export --output .\windows\winget.json
```

### Update packages

Chocolatey (elevated PowerShell):

```powershell
choco upgrade all -y
```

WinGet:

```powershell
winget upgrade --all
```

Review available upgrades and package overlap before updating applications through both package managers.

### Update PowerShell modules

```powershell
Update-Module PSReadLine
```

## Usage

### Add a configuration

```powershell
chezmoi add <path>
```

For example:

```powershell
chezmoi add "$PROFILE"
chezmoi add "$HOME\.gitconfig"
```

### Edit a configuration

Edit the chezmoi source file:

```powershell
chezmoi edit "$PROFILE"
```

Preview and apply the changes:

```powershell
chezmoi diff
chezmoi apply
```

### Capture local changes

Capture changes made directly to managed configuration files:

```powershell
chezmoi re-add
```

Or capture an individual file:

```powershell
chezmoi re-add "$HOME\.gitconfig"
```

### Inspect configuration

```powershell
chezmoi managed
chezmoi managed --include=files
chezmoi status
chezmoi diff
```

### Stop managing a configuration

```powershell
chezmoi forget <path>
```

This removes the file from chezmoi's source state without deleting the actual configuration file.

## Synchronization

### Local configuration to GitHub

Capture local changes, review them, and commit:

```powershell
chezmoi re-add

cd "$HOME\.dotfiles-windows"

git add .
git diff --cached
git commit -m "Update dotfiles"
git push
```

Package manifests can also be refreshed before committing:

```powershell
choco export .\windows\choco.config
winget export --output .\windows\winget.json
```

### GitHub to local configuration

Pull and apply remote changes:

```powershell
chezmoi update
```

Alternatively, preview changes before applying them:

```powershell
cd "$HOME\.dotfiles-windows"

git pull
chezmoi diff
chezmoi apply
```

Capture or otherwise preserve any local configuration changes before applying remote changes.
