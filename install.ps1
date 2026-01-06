<#
    .SYNOPSIS
    Powershell script for install and configure environment.
    
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

$ErrorActionPreference = 'Stop'

function InstallScoop {
    try {
        Clear-Host
        Write-Host "Checking if Scoop is present..." -ForegroundColor DarkCyan
        Start-Sleep -Seconds 2
        
        $null = scoop --version
        Write-Host "Scoop found." -ForegroundColor DarkGreen
        Start-Sleep -Seconds 2
    }
    catch {
        Clear-Host
        Write-Host "Scoop not found. Installing..." -ForegroundColor DarkBlue
        Start-Sleep -Seconds 2 
        
        try {
            Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
            Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
            Write-Host "Scoop installed successfully." -ForegroundColor DarkGreen
        }
        catch {
            Write-Host "Failed to install Scoop: $($_.Exception.Message)" -ForegroundColor Red
            exit 1
        }
    }
}

function CloneRepo {
    Write-Host "Checking if .dotfiles exists in '$HOME'..." -ForegroundColor DarkCyan
    
    if (Test-Path $HOME\.dotfiles) {
        Write-Host "Folder found. Updating..." -ForegroundColor DarkGreen
        try {
            Set-Location $HOME\.dotfiles
            git pull
            Write-Host "Repository updated successfully." -ForegroundColor DarkGreen
        }
        catch {
            Write-Host "Failed to update repository: $($_.Exception.Message)" -ForegroundColor Red
            exit 1
        }
    }
    else {
        Write-Host "Cloning config files to $HOME\.dotfiles..." -ForegroundColor DarkCyan
        try {
            git clone https://github.com/zandler/dotfiles-windows.git $HOME\.dotfiles
            Write-Host "Repository cloned successfully." -ForegroundColor DarkGreen
        }
        catch {
            Write-Host "Failed to clone repository: $($_.Exception.Message)" -ForegroundColor Red
            exit 1
        }
    }
    
    Start-Sleep -Seconds 2
}

######################
# SCRIPT STARTS HERE #
######################

Clear-Host

Write-Host "Installing Scoop..." -ForegroundColor DarkCyan
InstallScoop
Start-Sleep -Seconds 2

Clear-Host
Write-Host "Installing Git..." -ForegroundColor DarkCyan
try {
    scoop install main/git
    Write-Host "Git installed successfully." -ForegroundColor DarkGreen
}
catch {
    Write-Host "Failed to install Git: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
Start-Sleep -Seconds 2

Clear-Host 
CloneRepo

Write-Host "Starting configuration..." -ForegroundColor DarkCyan
Set-Location -Path $HOME\.dotfiles

if (Test-Path ".\bootstrap.ps1") {
    try {
        .\bootstrap.ps1
        Write-Host "Configuration completed successfully!" -ForegroundColor DarkGreen
    }
    catch {
        Write-Host "Failed to execute bootstrap.ps1: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
}
else {
    Write-Host "bootstrap.ps1 not found in the repository!" -ForegroundColor Red
    exit 1
}