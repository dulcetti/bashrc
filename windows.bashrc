# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# some ls and git aliases
alias gpdev='git pull origin develop'
alias st='git status'
alias ghdev='git push origin develop'
alias gitlol='git log --oneline --decorate --all --graph'
