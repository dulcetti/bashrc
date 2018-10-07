# verify if home brew has installed
if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
fi

# Add function that checks whether the git repository has modifications
function parse_git_dirty {
	[[ $(git status 2> /dev/null | tail -n1) != *"nothing to commit"* ]] && echo "*"
}
