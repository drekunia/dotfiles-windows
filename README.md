# My Windows dotfiles

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

### Initialize dotfiles

```powershell
chezmoi init https://github.com/drekunia/dotfiles-windows.git

cd (chezmoi git -- rev-parse --show-toplevel)
```

### Install PowerShell modules

```powershell
Install-Module PSReadLine -Repository PSGallery -Scope CurrentUser -Force
```

### Apply configuration

```powershell
chezmoi diff
chezmoi apply
```

Install [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads) if required by the Windows Terminal configuration, then restart the terminal.

Review machine-specific paths and terminal profiles after restoring the configuration.

## Packages

The package manifests are snapshots of installed applications, rather than curated installation lists. Review them for overlapping applications before restoring or updating packages.

Run the following commands from the repository root:

```powershell
cd (chezmoi git -- rev-parse --show-toplevel)
```

| Action                      | Command                                                                  |
| --------------------------- | ------------------------------------------------------------------------ |
| Restore Chocolatey packages | `choco install .\windows\choco.config -y`                                |
| Restore WinGet packages     | `winget import --import-file .\windows\winget.json --ignore-unavailable` |
| Export Chocolatey packages  | `choco export .\windows\choco.config`                                    |
| Export WinGet packages      | `winget export --output .\windows\winget.json`                           |
| Update Chocolatey packages  | `choco upgrade all -y`                                                   |
| Update WinGet packages      | `winget upgrade --all`                                                   |
| Update PowerShell modules   | `Update-Module PSReadLine`                                               |

Run Chocolatey restoration and upgrade commands from an elevated PowerShell session.

## Usage

| Command                             | Description                                                    |
| ----------------------------------- | -------------------------------------------------------------- |
| `chezmoi add <path>`                | Track a configuration file                                     |
| `chezmoi edit <path>`               | Edit a managed source file                                     |
| `chezmoi re-add`                    | Capture all local changes                                      |
| `chezmoi re-add <path>`             | Capture changes to a specific file                             |
| `chezmoi forget <path>`             | Stop managing a file without deleting the actual configuration |
| `chezmoi managed`                   | List managed paths                                             |
| `chezmoi managed --include=files`   | List managed files                                             |
| `chezmoi status`                    | Check configuration status                                     |
| `chezmoi diff`                      | Preview configuration changes                                  |
| `chezmoi apply --dry-run --verbose` | Simulate applying changes                                      |
| `chezmoi apply`                     | Apply configuration changes                                    |
| `chezmoi update`                    | Pull and apply remote changes                                  |
| `chezmoi source-path`               | Show the source state directory                                |
| `chezmoi cd`                        | Open a shell in the source directory                           |

After editing a managed source file, use `chezmoi diff` and `chezmoi apply` to preview and apply the changes.

## Synchronization

### Local configuration to GitHub

Capture local changes:

```powershell
chezmoi re-add

cd (chezmoi git -- rev-parse --show-toplevel)
```

Refresh package manifests if necessary:

```powershell
choco export .\windows\choco.config
winget export --output .\windows\winget.json
```

Review, commit, and push:

```powershell
git add .
git diff --cached
git commit -m "Update dotfiles"
git push
```

### GitHub to local configuration

Pull and apply remote changes:

```powershell
chezmoi update
```

Alternatively, preview changes before applying them:

```powershell
cd (chezmoi git -- rev-parse --show-toplevel)

git pull
chezmoi diff
chezmoi apply
```

Capture or otherwise preserve any local configuration changes before applying remote changes.
