# Requirements
# Windows 11
# Powershell Version > 5

<#
    .SYNOPSIS
    Powershell script for install and configure environemnt.
    
    .DESCRIPTION
    Requirements: 
        Powershell > 5
        Microsoft Windows 11
    Steps:
        - Install scoop 
        - Install Git Because you need clone this repo
        - Clone this repos at $HOME/.dotfiles 
        - Execute bootstrap.ps1 
          -   Install some softwares like jetbrains-font, dotnet, vscode. You can see inside bootstrap.ps1 at line 70 (if you had to add more, increase that list)
          - configure terminal with grovubox theme
#>

$ErrorActionPreference = 'SilentlyContinue' 

function InstallScoop {
    try {
        Clear-Host
        Write-Host "Check Scoop is present" -ForegroundColor DarkCyan
        Start-Sleep -Seconds 2
        
        scoop --version

        Write-Host "Scoop found." -ForegroundColor DarkCyan
        Start-Sleep -Seconds 2
    }
    catch {
        Clear-Host
        Write-Host "Scoop not found. Installing ..." -ForegroundColor DarkBlue
        Start-Sleep -Seconds 2 
        
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    }
}

write-host "Install Scoop" -foregroundcolor darkcyan
InstallScoop


scoop install main/git
