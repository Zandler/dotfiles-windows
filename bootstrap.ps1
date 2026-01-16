<#
    .SYNOPSIS
    Powershell script for install and configure environment.
    
    .DESCRIPTION
    Requirements: 
        Powershell > 5
        Windows 11
    Steps:
        Install Scoop
        Add Buckets for scoop (it's like apt repo)
        Install some softwares such like git, dotnet, fonts etc...
        Configure for Terminal (nvm, docker, starship)
        Install WSL (Windows subsystem for linux)
    
    PLUS:
        If you need, go to github.com/zandler/dotfiles-ubuntu and configure wsl with that. 

    
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

function AddScoopBuckets {
    Clear-Host

    $BUCKETS = "extras", "versions", "nerd-fonts"

    Write-Host "Adding buckets..." -ForegroundColor DarkCyan
    Start-Sleep -Seconds 2

    foreach($bucket in $BUCKETS) {
        try {
            Write-Host "Adding bucket: $bucket" -ForegroundColor DarkCyan
            scoop bucket add $bucket
            Write-Host "Bucket '$bucket' added successfully." -ForegroundColor DarkGreen
        }
        catch {
            Write-Host "Failed to add bucket '$bucket': $($_.Exception.Message)" -ForegroundColor Yellow
        }
        Start-Sleep -Seconds 1
    }

    Write-Host "Updating buckets..." -ForegroundColor DarkCyan
    try {
        scoop update
        Write-Host "Buckets updated successfully." -ForegroundColor DarkGreen
    }
    catch {
        Write-Host "Failed to update buckets: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

function InstallApps {
    Clear-Host

    Write-Host "Installing applications..." -ForegroundColor DarkCyan
    Start-Sleep -Seconds 2

    $DEFAULT_APPS = @(
        "extras/dbeaver",                     # Database management tool
        "extras/googlechrome",                # Web browser
        "extras/notepadplusplus",             # Text editor
        "extras/posh-git",                    # Git integration for PowerShell
        "extras/postman",                     # API testing tool
        "extras/powertoys",                   # Windows utilities
        "extras/psreadline",                  # PowerShell command line editing
        "extras/rider",                       # JetBrains .NET IDE
        "extras/soapui",                      # SOAP/REST API testing
        "extras/terminal-icons",              # Terminal file icons
        "extras/vscode",                      # Visual Studio Code editor
        "main/7zip",                          # File archiver
        "main/aws",                           # AWS CLI
        "main/azure-cli",                     # Azure CLI
        "main/eza",                           # Modern ls replacement
        "main/git",                           # Version control system
        "main/go",                            # Go programming language
        "main/golangci-lint",                 # Go linter
        "main/helix",                         # Terminal text editor
        "main/k9s",   
        "main/kubectl",                        # Kubernetes CLI manager
        "main/kubecolor",                     # Colorized kubectl output
        "main/powershell-yaml",               # YAML support for PowerShell
        "main/pwsh"                            # powreshell 7
        "main/sqlite",                        # SQLite database engine
        "main/starship",                      # Cross-shell prompt
        "main/terraform",                     # Infrastructure as code
        "main/terraform-ls",                  # Terraform language server
        "main/tflint",                        # Terraform linter
        "main/uv",                            # Python package installer
        "nerd-fonts/JetBrainsMono-NF",        # Programming font
        "nerd-fonts/JetBrainsMono-NF-Mono",   # Monospace programming font
        "versions/dotnet-sdk-lts",            # .NET SDK LTS version
        "versions/windows-terminal-preview"   # Windows Terminal preview
    )

    try {
        scoop update
    }
    catch {
        Write-Host "Failed to update Scoop: $($_.Exception.Message)" -ForegroundColor Yellow
    }

    $failed = @()
    foreach($app in $DEFAULT_APPS) {
        try {
            Write-Host "Installing: $app" -ForegroundColor DarkCyan
            scoop install $app
            Write-Host "Successfully installed: $app" -ForegroundColor DarkGreen
        }
        catch {
            Write-Host "Failed to install '$app': $($_.Exception.Message)" -ForegroundColor Yellow
            $failed += $app
        }
        Start-Sleep -Seconds 1
    }
    
    if ($failed.Count -gt 0) {
        Write-Host "Failed installations: $($failed -join ', ')" -ForegroundColor Yellow
    }
}

function GoApps {
    try {
        $null = go version
        Write-Host "Installing Go packages..." -ForegroundColor DarkCyan
        
        $goPackages = @(
            "github.com/air-verse/air@latest",
            "golang.org/x/tools/gopls@latest",
            "github.com/go-delve/delve/cmd/dlv@latest",
            "golang.org/x/tools/cmd/goimports@latest",
            "github.com/nametake/golangci-lint-langserver@latest"
        )
        
        foreach($package in $goPackages) {
            try {
                Write-Host "Installing Go package: $package" -ForegroundColor DarkCyan
                go install $package
                Write-Host "Successfully installed: $package" -ForegroundColor DarkGreen
            }
            catch {
                Write-Host "Failed to install '$package': $($_.Exception.Message)" -ForegroundColor Yellow
            }
        }
    }
    catch {
        Write-Host "Go not found. Skipping Go packages installation." -ForegroundColor Yellow
    }
}

function InstallWsl {
    Clear-Host 
    Write-Host "WSL Ubuntu installation will remove existing Ubuntu distro." -ForegroundColor DarkCyan
    Write-Host "All data will be erased. Continue? (Y/n)" -ForegroundColor DarkCyan
    $select = Read-Host

    if ($select -ne "Y") {
        Write-Host "Installation cancelled." -ForegroundColor Yellow
        return
    }

    try {
        # Check if Ubuntu exists before unregistering
        $wslList = wsl --list --quiet 2>$null
        if ($wslList -match "Ubuntu") {
            Write-Host "Removing existing Ubuntu distro..." -ForegroundColor DarkCyan
            wsl --unregister Ubuntu
        }
        
        wsl --set-default-version 2
        Write-Host "Installing WSL Ubuntu..." -ForegroundColor DarkCyan
        
        Write-Host "When WSL install finishes, setup username and password." -ForegroundColor DarkCyan
        Write-Host "After setup, type 'exit' to leave WSL." -ForegroundColor DarkCyan
        Write-Host "Visit https://github.com/zandler/dotfiles-ubuntu for Linux config." -ForegroundColor DarkCyan
        Write-Host "Press any key to continue..." -ForegroundColor DarkCyan
        Read-Host

        wsl --install -d Ubuntu
        Write-Host "WSL Ubuntu installation completed!" -ForegroundColor DarkGreen
    }
    catch {
        Write-Host "Failed to install WSL: $($_.Exception.Message)" -ForegroundColor Red
    }
}


function SyncConfig {
    Write-Host "Starting configuration sync..." -ForegroundColor DarkCyan
    Start-Sleep -Seconds 2

    # Create PowerShell profile directory if needed
    $profileDir = Split-Path $PROFILE -Parent
    if (-Not (Test-Path $profileDir)) {
        Write-Host "Creating PowerShell profile directory..." -ForegroundColor DarkGreen
        New-Item -ItemType Directory -Path $profileDir -Force
    }

    # Create .config directory
    if (-Not (Test-Path "$HOME\.config")) {
        Write-Host "Creating .config folder in $HOME" -ForegroundColor DarkGreen
        New-Item -ItemType Directory -Path "$HOME\.config" -Force
    }

    try {
        # PowerShell profile
        if (Test-Path "$HOME\.dotfiles\config\Microsoft.PowerShell_profile.ps1") {
            Copy-Item "$HOME\.dotfiles\config\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force
            Write-Host "PowerShell profile synced." -ForegroundColor DarkGreen
        }
        
        # Starship preset
        if (Test-Path "$HOME\.dotfiles\config\starship\starship.toml") {
            Copy-Item "$HOME\.dotfiles\config\starship\starship.toml" -Destination "$HOME\.config\starship.toml" -Force
            Write-Host "Starship config synced." -ForegroundColor DarkGreen
        }
        
        # Helix Editor profile
        if (Test-Path "$HOME\.dotfiles\config\helix") {
            Copy-Item "$HOME\.dotfiles\config\helix" -Destination "$Env:APPDATA\helix" -Force -Recurse
            Write-Host "Helix config synced." -ForegroundColor DarkGreen
        }
    }
    catch {
        Write-Host "Failed to sync some configs: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

function IsAdmin {
    try {
        $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
        $isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
        
        if ($isAdmin) {
            Write-Host "Running as administrator." -ForegroundColor DarkGreen
            return $true
        } else {
            Write-Host "Not running as administrator. WSL installation will be skipped." -ForegroundColor Yellow
            return $false
        }
    }
    catch {
        Write-Host "Failed to check admin privileges: $($_.Exception.Message)" -ForegroundColor Yellow
        return $false
    }
}

#########################
#   SCRIPT START HERE   #
#########################

InstallScoop # Install scoop
AddScoopBuckets # Add scoop buckets
InstallApps # Install applications
GoApps # Install Go packages
SyncConfig # Sync configuration files

# Load profile if it exists
if (Test-Path $PROFILE) {
    try {
        . $PROFILE
        Write-Host "PowerShell profile loaded." -ForegroundColor DarkGreen
    }
    catch {
        Write-Host "Failed to load profile: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

if (IsAdmin) {
    InstallWsl # Install WSL
}

Write-Host "SUCCESS! Please restart your terminal." -ForegroundColor DarkGreen
