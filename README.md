# DOTFILE-WINDOWS

## A submodule for dotfiles repo (http://github.com/Zandler/dotfiles)


### Requirements

- Local administrador
- Windows 11 (recomended a clean environment)
- WinGet
- Git 
- Powershell Core 

If you have a fresh windows 11 , you have this requirements. 


### Instructions 

- Update yout system
- Install dependencies 

'''powershell 

# Config Execution Policy
Set-ExecutionPolicy Unrestricted

# Install software
winget install -e --id Git.Git
winget install -e --id Microsoft.PowerShell.Preview

'''

- Clone this repo

'''powershell

git clone https://github.com/Zandler/dotfiles-windows.git 
'''

- Execute setup script 
'''powershel

.\dotfiles-windows\setup.ps1 
'''


