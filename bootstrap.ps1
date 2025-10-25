<#
    .SYNOPSIS
    Powershell script for install and configure environemnt.
    
    .DESCRIPTION
    Requirements: 
        Powershell > 5
        Windows 11
    Steps:
        Install Scoop
        Add Buckets for scoop (it`s like apt repo)
        Install some softwares such like git, dotnet, fonts etc...
        Configure for Terminal (nvm, docker, starship)
        Install WSL (Windows subsystem for linux)
    
    PLUS:
        If you need, go to github.com/zandler/dotfiles-ubuntu and cofnigure wsl with that. 

    
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
            "nerd-fonts"


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

    $DEFAULT_APPS="extras/dbeaver", 
    "extras/googlechrome", 
    "extras/notepadplusplus", 
    "extras/posh-git", 
    "extras/postman", 
    "extras/powertoys", 
    "extras/psreadline", 
    "extras/rider", 
    "extras/soapui", 
    "extras/terminal-icons", 
    "extras/vscode", 
    "main/7zip", 
    "main/aws", 
    "main/azure-cli", 
    "main/eza", 
    "main/git",
    "main/go", 
    "main/golangci-lint", 
    "main/helix", 
    "main/k9s", 
    "main/kubecolor", 
    "main/powershell-yaml", 
    "main/sqlite", 
    "main/starship", 
    "main/terraform", 
    "main/terraform-ls", 
    "main/tflint", 
    "main/uv", 
    "nerd-fonts/JetBrainsMono-NF", 
    "nerd-fonts/JetBrainsMono-NF-Mono", 
    "versions/dotnet-sdk-lts", 
    "versions/windows-terminal-preview"
        


    
    # Update System before install
    scoop update 

    foreach($app in $DEFAULT_APPS)
    {
        Clear-Host
        Write-Host "Installing app: "  $app  -ForegroundColor DarkCyan
        Start-Sleep -Seconds 3

        scoop install $app
    }
    # TODO
    # Check why profile not loded after install (terminal-icons problem)
    #Write-Host "Reload powershell" -ForegroundColor DarkCyan
    #. $PROFILE
}

function GoApps {
    go install github.com/air-verse/air@latest
    go install golang.org/x/tools/gopls@latest
    go install github.com/go-delve/delve/cmd/dlv@latest
    go install golang.org/x/tools/cmd/goimports@latest
    go install github.com/nametake/golangci-lint-langserver@latest
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
Don't worry after exit bash and finish all powershell process,
go to https://github.com/zandler/dotfiles-ubuntu
Press any key for continue
"  -ForegroundColor Darkcyan
    
    Read-Host

    wsl --install -d Ubuntu 

    Write-Host "Sucess!!  high five o/"
}


function SyncConfig {
    
    write-host "Starting config environment" -ForegroundColor DarkCyan
    Start-Sleep -Seconds 2

    if ( -Not (Test-Path "$PROFILE" )) {
        Write-Host "Creating profile folder and file" -ForegroundColor DarkGreen
        New-item -ItemType Directory -Path $HOME\Documents\WindowsPowerShell   
    }

    if ( -Not (Test-Path "$HOME\.config")) {
        write-host "Creating folder .config in $HOME"
        New-Item -ItemType Directory -Path $HOME\config
    }

    # Porwershell profile 
    Copy-Item $HOME\.dotfiles\config\Microsoft.PowerShell_profile.ps1 -Destination $HOME\DOCUMENTS\WindowsPowerShell\ -Force
    # Powershell ISE Profile
    Copy-Item $HOME\.dotfiles\config\Microsoft.PowerShell_profile.ps1 -Destination $PROFILE -Force
    # Startship preset
    Copy-Item $HOME\.dotfiles\config\starship\starship.toml $HOME\.config\starship.toml
    # Helix Editor profile
    Copy-Item $HOME\.dotfiles\config\helix -Destination $Env:APPDATA\helix -Force -Recurse
 
}

function IsAdmin {
    # Verifica se o script está sendo executado com privilégios de administrador local
    $adminGroup = [System.Security.Principal.WindowsBuiltInRole]::Administrator
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $isAdmin = $currentUser.Groups -match "S-1-5-32-544"  # SID do grupo "Administradores"

    if ($isAdmin) {
        Write-Host "You'r local admin. "
    } else {
        Write-Host "You are not admin local. Skip Install WSL "
    Exit
    }
}

#########################
#   SCRIPT START HERE   #
#########################

SyncConfig # Config files for some apps like helix starship
InstallScoop # Install scoop
AddScoopButckets # Add scoop buckets like debian repos
InstallApps # Install all apps for windows (python, golang, node are inside WSL see: https://github.com/zandler/dotfiles-ubuntu)
GoApps

. $PROFILE 

if (IsAdmin) {
    InstallWsl # Intall Wsl for SRE - python - node - docker
}

Write-Host "SUCESS. RESTART TERMINAL..." -ForegroundColor DarkCyan
