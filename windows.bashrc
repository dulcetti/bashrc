# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Add function that checks whether the git repository has modifications
function parse_git_dirty {
	[[ $(git status 2> /dev/null | tail -n1) != *"nothing to commit"* ]] && echo '*'
}

# some ls and git aliases
alias ls='ls -la --color=auto'
alias gpdev='git pull origin develop'
alias st='git status'
alias ghdev='git push origin develop'
alias gitlol='git log --oneline --decorate --all --graph'
