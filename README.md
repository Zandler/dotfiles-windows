# DOTFILE-WINDOWS

## A submodule for dotfiles repo (http://github.com/Zandler/dotfiles)
### But you can use only this.... 

### Objectives
Configure my terminal and install some apps that i need in my work. 
This repos ins`t for everyone, you can use if you want, but first, read the script.


### Why Scoop?

Scoop act like apt with some security precautions:
    - You dont need admin rigths
    - scoop creates a scoop folde rin your $HOME ans install all apps inside
    - Scoop add in PATH to the folder and *voil'a* 

More security and agility, less complexity and problem with SecIT

### Requirements

- Windows 11 (recomended a clean environment)
- Powershell > 5

### Instructions 

1. Update yout system
2. Install dependencies 
3. Run this two commands  in powershell **(No admin local need.)**

```powershell

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

Iwr -Uri https://raw.githubusercontent.com/Zandler/dotfiles-windows/refs/heads/main/install.ps1 -OutFile install.ps1; ./install.ps1

```

Set-executionPolicy allow you execute powershell script **ONLY** in your current user.

This script:
- Install scoop
- Install git
- Clone this repo
- Install some apps
- Config terminal
- Install WSL , if you are admin local. If not, skip this step.

## Add more app and buckets

**Buckets** = are like apt repositories. You can found some apps inside.
**Apps** = applications for you needs. 

**If you want install more softwares, go to https://scoop.sh/#/apps and search you app. 

After found , edit resources.json file add inside buckets or apps. The script will read this file

