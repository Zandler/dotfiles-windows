# DOTFILE-WINDOWS

## A submodule for dotfiles repo (http://github.com/Zandler/dotfiles)


### Requirements

- Windows 11 (recomended a clean environment)
- Git 
- Powershell > 5


### Instructions 

1. Update yout system
2. Install dependencies 
3. Clone this repo

'''powershell

git clone https://github.com/Zandler/dotfiles-windows.git 

cd dotfiles-windows
.\install.ps1
'''

This script:
- Create a foder with name devxp at $HOME 
- Move some config files inside $HOME\.devxp\config folder (Powershell profile included)
- Install WSL2 because Rancher desktop needs wsl.
- Install Scoop
- Add some buckets to scoop
- Install apps
**If you want install more softwares, go to https://scoop.sh/#/apps and search you app. Next add after line 98**

