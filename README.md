# DOTFILE-WINDOWS

## A submodule for dotfiles repo (http://github.com/Zandler/dotfiles)
### But you can use only this.... 

### Requirements

- Windows 11 (recomended a clean environment)
- Powershell > 5

### Instructions 

1. Update yout system
2. Install dependencies 
3. Run this command  in powershell **(No admin local need.)**

```powershell
 Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Iwr -Uri https://raw.githubusercontent.com/Zandler/dotfiles-windows/refs/heads/main/install.ps1 -OutFile install.ps1; ./install.ps1

```

This script:
- Install scoop
- Install git
- Clone this repo
- Install some apps
- Config terminal
- Install WSL , if you are admin local. If not, skip this step.

**If you want install more softwares, go to https://scoop.sh/#/apps and search you app. Next add after line 70**

