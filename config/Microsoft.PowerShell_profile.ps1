Set-StrictMode -Version 3.0 
$ErrorActionPreference = 'Continue'

# Icons on terminal
try {
    Import-Module Terminal-Icons -Scope Global -ErrorAction Stop
} catch {
    Write-Warning "Terminal-Icons module not found. Install with: scoop install extras/terminal-icons"
}

try {
    Import-Module PSReadLine -Scope Global -ErrorAction Stop
    Set-PSReadLineKeyHandler -Key Tab -Function Complete 
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
} catch {
    Write-Warning "PSReadLine module not found. Install with: scoop install extras/psreadline"
}

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
    git log --oneline
}

function glc {
    git log -1 HEAD --stat
}

function grb {
    git branch -r -v
}

function gcm {
    git commit -m
}

# Kubernetes aliases using kubecolor
function k {
    kubecolor $args
}

function kgp {
    kubecolor get pods $args
}

function kgs {
    kubecolor get svc $args
}

function kgd {
    kubecolor get deploy $args
}

function kgn {
    kubecolor get nodes $args
}

function kgns {
    kubecolor get namespaces $args
}

function kdp {
    kubecolor describe pod $args
}

function kds {
    kubecolor describe svc $args
}

function kdd {
    kubecolor describe deploy $args
}

function kdn {
    kubecolor describe node $args
}

function kl {
    kubecolor logs $args
}

function klf {
    kubecolor logs -f $args
}

function kex {
    kubecolor exec -it $args
}

function kpf {
    kubecolor port-forward $args
}

function ka {
    kubecolor apply -f $args
}

function kd {
    kubecolor delete $args
}

function kgc {
    kubecolor config get-contexts
}

function kcc {
    kubecolor config use-context $args
}

function Get-GitBranch {
    param(
        [string]$RepositoryPath = (Get-Location).Path
    )

    if (Test-Path "$RepositoryPath\.git") {
        $branch = git branch --show-current
        return $branch
    } else {
        Write-Warning "Diretório atual '$RepositoryPath' não é um repositório git."
        return $null
    }
}

Set-Variable -Name STARSHIP_CONFIG -Value $HOME\.config\starship.toml

# Starship
try {
    if (Get-Command starship -ErrorAction SilentlyContinue) {
        Invoke-Expression (&starship init powershell)
    } else {
        Write-Warning "Starship not found. Install with: scoop install main/starship"
    }
} catch {
    Write-Warning "Error initializing Starship: $($_.Exception.Message)"
}