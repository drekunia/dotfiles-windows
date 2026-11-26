# Windows Dotfiles

My personal Windows configuration files, managed with [chezmoi](https://www.chezmoi.io/).

For my Linux/WSL configuration, see [`.dotfiles`](https://github.com/drekunia/.dotfiles).

## Setup

Install Git and chezmoi from an elevated PowerShell session:

```powershell
choco install git chezmoi -y
```

Restart PowerShell as a regular user and configure the execution policy:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Initialize the dotfiles repository:

```powershell
chezmoi init --source "$HOME\.dotfiles-windows" https://github.com/drekunia/.dotfiles-windows.git
```

Navigate to the repository:

```powershell
cd "$HOME\.dotfiles-windows"
```

Install PowerShell modules and apply Windows preferences:

```powershell
.\scripts\install-modules.ps1
.\scripts\windows-settings.ps1
```

Preview and apply the configuration:

```powershell
chezmoi diff
chezmoi apply --dry-run --verbose
chezmoi apply
```

Restart the terminal.

## Packages

The repository contains snapshots of installed Windows applications. These lists may contain overlapping packages and should be reviewed before restoration.

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

## Usage

Add a configuration file:

```powershell
chezmoi add <path>
```

Capture changes to managed files:

```powershell
chezmoi re-add
```

Edit a managed configuration:

```powershell
chezmoi edit <path>
```

Inspect managed configurations and pending changes:

```powershell
chezmoi managed
chezmoi status
chezmoi diff
```

Apply configurations:

```powershell
chezmoi apply
```

Pull and apply remote changes:

```powershell
chezmoi update
```

Commit configuration changes:

```powershell
cd "$HOME\.dotfiles-windows"

git add .
git commit -m "Update dotfiles"
git push
```
