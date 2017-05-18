# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Add function that checks whether the git repository has modifications
function parse_git_dirty {
	[[ $(git status 2> /dev/null | tail -n1) != *"nothing to commit"* ]] && echo '*'
}

function parse_git_branch {
	local git_status="$(git status 2> /dev/null)"

	if [[ $git_status =~ "nothing to commit" ]]; then
		echo -e "\033[0;32m"
	elif [[ $git_status == "" ]]; then
		echo $'\033[00m\n '
	elif [[ $git_status =~ "Changes to be committed:" ]]; then
		echo $'\033[93m'
	else
		echo -e "\033[0;31m"
	fi

	git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\(\1$(parse_git_dirty)\) /"
}

# some ls and git aliases
alias ls='ls -la --color=auto'
alias gpdev='git pull origin develop'
alias st='git status'
alias ghdev='git push origin develop'
alias gitlol='git log --oneline --decorate --all --graph'
