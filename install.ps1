
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
    if ( -Not (Test-Path "$HOME/.dotfiles" )) {
        Write-Host "folder not found. Cloning repo..." -ForegroundColor DarkGreen
        git clone https://github.com/zandler/dotfiles-windows.git $HOME\.dotfiles 
    }
    Start-Sleep -Seconds 2
    Clear-Host

    Write-Host "Folder found. Updating..."
    cd $HOME\.dotfiles ; git pull
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

Write-Host "Now, starting all conf" -ForegroundColor DarkCyan
cd $HOME\.dotfiles; .\bootstrap.ps1
