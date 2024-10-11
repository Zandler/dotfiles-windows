function IsAdmin {
    return ([Security.Principal.WindowsPrincipal] `
              [Security.Principal.WindowsIdentity]::GetCurrent() `
              ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    
}

function CheckRequirements
{
    Write-Host "1. Check SO" -ForegroundColor DarkCyan
    Start-Sleep -s 2
    if($Env:OS -notlike "*Windows*")
    {
        write-host "> This is only for Microsoft Windows 11" -ForegroundColor DarkRed
        Start-Sleep -Seconds 3
    }
    
    write-host "2. Check Local admin (this user is in administrator group)" -ForegroundColor DarkCyan
    Start-Sleep -Seconds 2
    
    if(!(IsAdmin)) 
    {   
        write-host "You need local admin." -ForegroundColor DarkRed
            Start-Sleep -Seconds 3
            Exit
    }
    
}

# REGEDIT for change some thing in windows 
function ConfigWindowsEnvironment 
{
    # Terminal icons module
    Install-Module -Name Terminal-Icons -Repository PSGallery
    # PSReeadLine
    Install-Module -Name PSReadLine -Repository PSGallery -Force
    
    #REGEDIT
    # Enable long path
    Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

    # Show file extensions in windows explorer
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name HideFileExt -Value 0

}
# Install Basic Software for windows only (all developmente/devops is inside WSL)
function WingetInstallTools
{

    
    Write-Host "Installing some tools. Go get a coffe, this take some time..."
    winget import --accept-package-agreements --accept-source-agreements --ignore-unavailable --import-file extra\winget.json

}

# Install Clean WSL 
function InstallWsl 
{
    Clear-Host

    write-host "
I need to remove and install again (like ansible/terraform).
All your data will be lost.
Continue? (y/N)" -ForegroundColor DarkCyan


    $select = Read-Host 

    if ($select -ne "y") {
        Exit-PSHostProcess
    }

    wsl --unregister Ubuntu 
    wsl --set-default-version 2

    write-host "
WSL erased. 
Install WSL. "
Start-Sleep -Seconds 3 

clear-host

write-host "
When WSL install finish you need to setup username and password.
Create your username and password, after, type  'exit' for leave wsl. 

Press any key for continue
"  -ForegroundColor Red
    Read-Host

    wsl --install -d Ubuntu
    Start-Sleep -Seconds 3

}

function HelixEditor
{

    $appData = $Env:APPDATA
    
    if (-Not (Test-Path $appData\helix))
    {
        New-Item -Type Directory $appData\helix
    }

    Copy-Item .\extra\helix-config.toml $appData\helix\config.toml
    Copy-Item .\extra\helix-languages.toml $appData\helix\languages.toml  
}

# Configure oh my posh with fonts and theme. 
# TODO: Create a video with windows terminal config 
function OhMyPosh
{
    $profilePath = $PROFILE


    $profileDir = Split-Path -Path $profilePath -Parent

    Copy-Item .\extra\Microsoft.PowerShell_profile.ps1 $PROFILE

    # Reload Profile 
    . $PROFILE
            
    # jetbrainsfont 
    oh-my-posh font install JetBrainsMono
}

function init-setup
{

    CheckRequirements

    ConfigWindowsEnvironment   
    
    WingetInstallTools

    HelixEditor 
        
    OhMyPosh 

    InstallWsl
}

init-setup
