# My Windows dotfiles

My personal Windows configuration files, managed with [chezmoi](https://www.chezmoi.io/).

For my Linux/WSL configuration, see [dotfiles](https://github.com/drekunia/dotfiles).

## Setup

### Install dependencies

I use [Chocolatey](https://chocolatey.org/install) with Windows `sudo` enabled.

```powershell
sudo choco install git chezmoi zoxide fzf starship -y
```

Restart PowerShell, then configure the execution policy:

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

Install [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads), then restart the terminal.

[Zed](https://zed.dev/) is used as the default editor in PowerShell when available.

### Git

Git configuration and global ignore rules are located in `~/.config/git/`. Adjust the identity and any machine-specific paths in `config` if needed.

SSH signing is enabled for commits and tags. With Windows OpenSSH installed, enable the SSH agent in an elevated PowerShell:

```powershell
Set-Service ssh-agent -StartupType Automatic
Start-Service ssh-agent
```

Import an SSH key, then load it in a regular PowerShell:

```powershell
& "$env:WINDIR\System32\OpenSSH\ssh-add.exe" "$HOME\.ssh\id_ed25519"
```

or disable signing in `~/.config/git/config`.

## Packages

The package manifests are snapshots of installed applications, not curated installation lists. Review them before restoring packages.

To refresh the manifests:

```powershell
cd (chezmoi git -- rev-parse --show-toplevel)
choco export .\packages\choco.config
winget export --output .\packages\winget.json
```
