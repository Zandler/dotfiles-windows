Set-StrictMode -Version 3.0
$ErrorActionPreference = 'Stop'

Import-Module Terminal-icons


# Improvements 
Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward


# Aliases functions

# LIST
function ls
{
    eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons 
}

function ll
{
    eza --tree --level=2 --color=always --group-directories-first --icons
}

# GIT
function ga
{
    git add .
}

function gca
{
    git commit --amend --verbose 
}

function gco
{
    git checkout 
}

function gcob
{
    git checkout -b
}

# git list local branchs sorted by last modified
function glbm
{
    git for-each-ref --sort=-committerdate --format='%(refname:short) %09 %(committerdate:relative)' refs/heads/
}

# git list remote branchs sroted by last modified
function glbmr
{
    git for-each-ref --sort=-committerdate --format='%(refname:short) %09 %(committerdate:relative)' refs/remotes/
}

function gs
{
    git status -sb
}

function gl
{
    git log --online
}

# show last commit
function glc
{
    git log -1 HEAD --stat    
}

# show remote branchs and description
function grb
{
    git branch -r -v 
}

function gmt
{
    git commit -m
}

# Init oh-my-posh
oh-my-posh --init --shell pwsh --config  ~\.dotfiles\dotfiles-windows\extra\poshTheme.omp.json | Invoke-Expression

