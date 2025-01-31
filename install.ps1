# Requirements
<#
    .SYNOPSIS
    Powershell script for install and configure environemnt.
    
    .DESCRIPTION
    Requirements: 
        Powershell > 5
        Windows 11
    Steps:
        - Install scoop
        - install git
        - clone repo
        - execute bootstrap.ps1
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

function CloneRepo {

    
    Write-Host "Check if .dotfiles exists in '$HOME' " -ForegroundColor DarkCyan
    if (Test-Path $HOME\.dotfiles) {
        Write-Host "folder found. Update..." -ForegroundColor DarkGreen
        cd $HOME\.dotfiles ; git pull
        Start-Sleep -Seconds 2
        Clear-Host
    }

    Write-Host "Clone config files at $HOME\.dotfiles ..."
    git clone https://github.com/zandler/dotfiles-windows.git $HOME\.dotfiles 
    cd $HOME\.dotfiles ; 
    Start-Sleep -Seconds 2
}

Clear-Host

write-host "Installing Scoop..." -foregroundcolor darkcyan
InstallScoop
Start-Sleep -Seconds 2

Clear-Host

Write-Host "Installing Git" 
scoop install main/git
Start-Sleep -Seconds2

Clear-Host 

CloneRepo

Write-Host "Now, starting all conf" -ForegroundColor DarkCyan
Set-Location -Path $HOME\.dotfiles       
.\bootstrap.ps1

