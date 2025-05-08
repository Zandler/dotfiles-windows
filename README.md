# DOTFILE-WINDOWS

![](./image.png)

## FEATURES
- syntax-highlight
- complete preview
- some SRE apps such like kubectl, terraform,,,


### **PLEASE, READ THE FILES ! ! !**


## What
This repo contain powershell scripts and conf files. You can configure you environment for a SRE WORK!!!

**No need admin rights**

## Requirements

- Windows 11 (recomended a clean environment)
- Powershell > 5

## Instructions 

1. Update yout system 
2. Run this command  in powershell **(No admin local need.)**

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

**If you want see or install more softwares, go to https://scoop.sh/#/apps and search you app. Next add after line 110**

After execute , install wsl.

```powershell

wsl --install -d Ubuntu
```

if you need configure linux environment, go to dotfiles folder and configure linux. **[Linux-dotfiles](https://github.com/Zandler/dotfiles)**


Enjoy!!!

