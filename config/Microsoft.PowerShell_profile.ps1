Set-StrictMode -Version 3.0 
$ErrorActionPreference = 'Stop'

# Icons on terminal
Import-Module Terminal-Icons -Scope Global  

# Improvements
Import-Module PSReadLine -Scope Global
Set-PSReadLineKeyHandler -Key Tab -Function Complete 
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward

# LOAD ALIAS 
function ls {
    eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons
}

function ll {
    eza --tree --level=2 --color=always --group-directories-first --icons
}

function ga {
    git add .
}

function gca {
    git commit --amend --verbose
}

function gco {
    git checkout
}

function gcob {
    git checkout -b
}

# List local branchs sort by last modified 
function glbm {
    git for-each-ref --sort=-committerdate --format='%(refname:short) %09 %(committerdate:relative)' refs/heads/
}

# git list remote branchs sorted by last modified
function glbmr {
    git for-each-ref --sort=-committerdate --format='%(refname:short) %09 %(committerdate:relative)' refs/remotes/
}

function gs {
    git status -sb
}

function gl {
    git log --online
}

function glc {
    git log -1 HEAD --stat
}

function grb {
    git branch -r -v
}

function gcm {
    git coomit -m
}

function Get-GitBranch {
    param(
        [string]$RepositoryPath = (Get-Location).Path
    )

    if (Test-Path "$RepositoryPath\.git") {
        $branch = git branch --show-current -b
        return $branch
    } else {
        Write-Warning "Direcotrio atual '$RepositoryPath' não é um repositorio git."
        return $null
    }
}

Set-Variable -Name STARSHIP_CONFIG -Value $HOME\.devxp\starship\starship.toml
# Create alis to kubectl (kubecolor == kubectl with color)
Set-Alias -Name kubectl -Value kubecolor

# Starship
Invoke-Expression (&starship init powershell)