# My Windows dotfiles

My personal Windows configuration files, managed with [chezmoi](https://www.chezmoi.io/).

For my Linux/WSL configuration, see [`.dotfiles`](https://github.com/drekunia/.dotfiles).

## Setup

### Install dependencies

I have `sudo` enabled.

```powershell
sudo choco install git chezmoi zoxide fzf -y
```

Restart PowerShell to refresh the environment variables, then configure the execution policy:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Initialize dotfiles

```powershell
chezmoi init https://github.com/drekunia/dotfiles-windows.git

cd (chezmoi git -- rev-parse --show-toplevel)
```

### Install PowerShell modules

```powershell
.\scripts\install-modules.ps1
```

### Apply configuration

```powershell
chezmoi apply
```

Install [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads) for Windows Terminal and Terminal-Icons, then restart the terminal.

[Zed](https://zed.dev/) is used as the default editor when available.

Review machine-specific paths and terminal profiles after restoring the configuration.

## Packages

The package manifests are snapshots of installed applications, rather than curated installation lists. Review them for overlapping applications before restoring or updating packages.

To refresh package manifests:

```powershell
cd (chezmoi git -- rev-parse --show-toplevel)
choco export .\windows\choco.config
winget export --output .\windows\winget.json
```
