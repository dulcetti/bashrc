# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Add function that checks whether the git repository has modifications
function parse_git_dirty {
	[[ $(git status 2> /dev/null | tail -n1) != *"nothing to commit"* ]] && echo "*"
}

# Add function to show which git branch my folder is selected
function parse_git_branch {
	# variable to check the git status message
	local git_status="$(git status 2> /dev/null)"

	# if the repository is cleaned, change the color to green
	if [[ $git_status =~ "nothing to commit" ]]; then
		echo -e "\033[0;32m"
	# if the folder it is not a git repository, change the color to light gray
	elif [[ $git_status == "" ]]; then
		echo $'\033[00m\n '
	# if the repository has files added and changes to be commited, change the color to light yellow
	elif [[ $git_status =~ "Changes to be committed:" ]]; then
		echo $'\033[93m'
	# if the repository has modifications and no files added, change the color to red
	else
		echo -e "\033[0;31m"
	fi

	git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\(\1$(parse_git_dirty)\) /"
}

# Create PS1 with new empty line
PS1="\n"

# Set color to Light blue, show Date in format DD/MM/YYY and Hour in format HH:MM:SS and break line
PS1+="\033[0;94m\D{%d/%m/%Y} - \T\n"

# Set color to yellow and show the user with @, set color to white and show the current path
PS1+="\[\033[33m\]@\u \[\033[0;97m\]\w"

# Execute parse_git_branch function to show the current branch, reset the color and print $
PS1+="\$(parse_git_branch)\[\033[00m\]$ "

# Export the configuration
export PS1

# some ls and git aliases
alias ls='ls -la --color=auto'
alias gpdev='git pull origin develop'
alias st='git status'
alias ghdev='git push origin develop'
alias gitlol='git log --oneline --decorate --all --graph'
