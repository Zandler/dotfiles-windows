# DOTFILE-WINDOWS

## A submodule for dotfiles repo (http://github.com/Zandler/dotfiles)


### Requirements

- Windows 11 (recomended a clean environment)
- WinGet
- Git 
- Powershell Core 


### Instructions 

- Update yout system
- Install dependencies 

'''powershell 

winget install -id -e Git.Git
winget install Microsoft.PowerShell
'''

- Clone this repo
'''powershell

git clone https://github.com/Zandler/dotfiles.git
'''

- Execute setup script 
'''powershel

.\dotfiles-windows\setup.ps1 
'''


