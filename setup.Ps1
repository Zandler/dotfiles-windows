<#
    .SYNOPSIS
    Powershell script for install and configure environment.
    
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

$ErrorActionPreference = 'SilentyContinue'

function SysConfig
{
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

    Start-Sleep -Seconds 10
}

function ScoopBuckets
{
    param (
        [string[]]$buckets
    )

    Clear-Host

    foreach ($bucket in $buckets)
    {
        Write-Host " Add Bucket: " $bucket -ForegroundColor DarkGray
        scoop bucket add $bucket
    } 
    Write-Host " Update buckets..." -ForegroundColor Cyan

    scoop update
}

function InstallScoopApps
{
    param (
        [string[]]$apps
    )

    clear-host

    foreach ($app in $apps)
    {
        $appName =($app -split "/")[1] 
        Write-host " Installing " $appName  -ForegroundColor Cyan 
        scoop install $app
    }
}

function IsAdmin
{
    # Check if current user in terminal is local admin.
    $adminGroup = [System.Security.Principal.WindowsBuiltInRole]::Administrator
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $isAdmin = $currentUser.Groups -match "S-1-5-32-544"  # SID of local admin"

    if ($isAdmin) {
       
       Write-Host "You're local admin. " -ForegroundColor Green
       return $true
        
    } else {

        Write-Host "You are not admin local. Skip Install WSL " -ForegroundColor DarkRed
        return $false
        
    }
}

function InstallWsl 
{
    Clear-Host 
    Write-Host "
I need to remove Ubuntu distro. All data will erased.
Continue? ( Y/n)" -ForegroundColor DarkRed
   
    $select = Read-Host

    while ($select -ne "Y" )
    {
        Write-Host "You desagree. Exiting" -ForegroundColor DarkRed
        Start-Sleep -Seconds 2
        return
    }

    wsl --unregister Ubuntu
    wsl --set-default-version 2

    Write-Host "WSL removed" -ForegroundColor DarkGreen
    Start-Sleep -Seconds 2
    Clear-Host
    write-host "
When WSL install finish you need to setup username and password.
Create your username and password, after, input 'exit' for leave wsl. 
Don't worry after exit bash and finish all powershell process,
go to https://github.com/zandler/dotfiles-ubuntu
Press any key for continue
"  -ForegroundColor Cyan
    
    Read-Host

    wsl --install -d Ubuntu 

    Write-Host "Sucess!!  high five o/" -foregroundcolor green
}

# ================== 
# SCRIPTS START HERE   
# ==================

#load resources.json to object. 
# You can add buckets and apps. Just get infor about then in  https://scoop.sh/
$jsonFiles = Get-Content .\resources.json -Raw
$resources = $jsonFiles | ConvertFrom-Json

#SysConfig
#AddScoopBuckets

#ScoopBuckets -buckets $resources.buckets
#InstallScoopApps -apps $resources.apps

if (IsAdmin)
{
    Write-Host "WSL - Read the prompt. That`s critic" -ForegroundColor DarkRed
    InstallWsl
}
Write-Host "That`s it. Reload you powershell and Enjoy!!!"

. $PROFILE
