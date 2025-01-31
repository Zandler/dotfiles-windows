# Requires Powershell Version > 5 

<#
    .SYNOPSIS
    Powershell script for install and configure environemnt.
    
    .DESCRIPTION
    Requirements: 
        Powershell > 5
    Secionts:
        Install some softwares such like git
        Configure for Terminal (nvm, docker, starship)
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

function AddScoopButckets {
    Clear-Host

    $BUCKETS="extras",
            "versions",
            "nerd-fonts",
            "java"
    Write-Host "Add buckets" -ForegroundColor DarkCyan
    Start-Sleep -Seconds 3

    foreach($bucket in $BUCKETS)
    {
        Clear-Host
        Write-Host "Add bucket: "  $bucket  -ForegroundColor DarkCyan
        Start-Sleep -Seconds 2
        scoop bucket add $bucket

    }

    Write-Host "Update buckets" -ForegroundColor DarkCyan
    Start-Sleep -Seconds 3
    
    scoop update
}

function InstallApps {

    Clear-Host

    write-host "Installing some softwares (git and some stuff)" -ForegroundColor DarkCyan
    Start-Sleep -Seconds 3 

    $DEFAULT_APPS="main/git",
        "extras/windows-terminal",
        "extras/vscode",
        "extras/notepadplusplus",
        "extras/powertoys",
        "extras/rancher/desktop",
        "main/7zip",
        "nerd-fonts/JetBrainsMono-NF",
        "nerd-fonts/JetBrainsMono-NF-Mono",
        "main/eza",
        "extras/bruno",
        "main/helix",
        "extras/dbeaver",
        "main/aws",
        "main/starship",
        "main/k9",
        "extras/terminal-icons",
        "extras/posh-git",
        "extras/dockercompletion",
        "extras/psreadline",
        "main/powershell-yaml",
        "java/oraclejre8",
        "main/omnisharp",
        "main/netcoredbg",
        "versions/dotnet6-sdk",
        "version/dotnet-sdk",
        "main/k6",
        "main/docker-compose",
        "main/kubecolor"
    
    # Update System before install
    scoop update 

    foreach($app in $DEFAULT_APPS)
    {
        Clear-Host
        Write-Host "Installing app: "  $app  -ForegroundColor DarkCyan
        Start-Sleep -Seconds 3

        scoop install $app
    }
}
function InstallWsl {
    Clear-Host 
    Write-Host "
I need to remove Ubuntu distro. All data will erased.
Continue? ( Y/n)" -ForegroundColor DarkCyan
    $select = Read-Host

    while ($select -ne "Y" )
    {
        Write-Host "You desagree. Exiting"
        Start-Sleep -Seconds 2
        return
    }

    wsl --unregister Ubuntu
    wsl --set-default-version 2

    Write-Host "WSL removed" -ForegroundColor Darkcyan
    Start-Sleep -Seconds 2
    Clear-Host
    write-host "
When WSL install finish you need to setup username and password.
Create your username and password, after, input 'exit' for leave wsl. 
Don't worry after exit bash and finish all powershell process, We will configure bash.
Press any key for continue
"  -ForegroundColor Darkcyan
    
    Read-Host

    wsl --install -d Ubuntu 

    Write-Host "Sucess!!  high five o/"
}

function SyncConfig {
    
    write-host "Checking if devxp directory exists..." -ForegroundColor DarkCyan
    Start-Sleep -Seconds 2

    if ( -Not (Test-Path "$HOME/.devxp" )) {
        Write-Host "Creating devxp folder for config files" -ForegroundColor DarkGreen
        New-item -ItemType Directory -Path $HOME\.devxp 
    }

    Copy-Item .\config -Destination $HOME\.devxp\ -Recurse

    write-host "Copy config files... (all files are locate in $HOME/.devxp)" -ForegroundColor DarkCyan

    Copy-Item $HOME\.devxp\helix\* -Destination $HOME\AppData\Roaming\helix\ -Force
    
    Copy-Item $HOME\.devxp\Microsoft.PowerShell_profile.ps1 -Destination $PROFILE -Force
    
    
}

InstallWsl # Intall Wsl for SRE - python - node - docker
SyncConfig # Config files for some apps like helix starship
InstallScoop # Install scoop
AddScoopButckets # Add scoop buckets like debian repos
InstallApps # Install all apps for windows (python, golang, node are inside WSL see: https://github.com/zandler/dotfiles-ubuntu)
