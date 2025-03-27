# Requirements
<#
    .SYNOPSIS
    Powershell script for install and configure sccop and git
    
    .DESCRIPTION
    Requirements: 
        Powershell > 5
        Windows 11
    Steps:
        - Install scoop
        - install git
        - clone repo
        - execute sertup.Ps1
#>

$ErrorActionPreference = 'SilentlyContinue' 

function InstallScoop 
{
    try {

        
        Write-Host "Check Scoop is present" -ForegroundColor DarkCyan
        Start-Sleep -Seconds 2
        
        scoop --version

        Write-Host "Scoop found." -ForegroundColor Green
        Start-Sleep -Seconds 2

    }
    catch 
    {

        Write-Host "Scoop not found. Installing ..." -ForegroundColor DarkRed
        Start-Sleep -Seconds 2 
        
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

        Write-Host "Scoop Installed. Enjoy." -ForegroundColor DarkGreen
        Start-Sleep -Seconds 3
    }
}

function InstallGit 
{
    Write-Host "Installing Git with scoop..." -ForegroundColor DarkCyan
    Start-Sleep -Seconds 3

    scoop install main/git
}


function CloneRepo {

    
    Write-Host "Check if .dotfiles folder exists in '$HOME' " -ForegroundColor DarkCyan
    Start-Sleep -Seconds 2
    if (Test-Path $HOME\.dotfiles) {
        Write-Host "folder found. Update..." -ForegroundColor Green
        cd $HOME\.dotfiles ; git pull
        Start-Sleep -Seconds 2
        Clear-Host
    }
    Write-Host "Folder not found. Creating folder." -ForegroundColor DarkCyan
    Write-Host "Clone config files at $HOME\.dotfiles ..." -ForegroundColor DarkCyan
    git clone https://github.com/zandler/dotfiles-windows.git $HOME\.dotfiles 
    cd $HOME\.dotfiles ; 
    Write-Host "Folder created, repo cloned." -ForegroundColor Green
    Start-Sleep -Seconds 2
}



function Init {
    Clear-Host
    Write-Host " 
    =========================================
    = Config Windows Environment            =
    = Author: Zandler <zandler@outlook.com> =
    = Version: 0.9                          =
    = github.com/zandler/dotfiles-windows   =
    ========================================= " -ForegroundColor Green
    Start-Sleep -Seconds 3

}

Clear-Host 

Init
InstallScoop
InstallGit
CloneRepo