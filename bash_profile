function command_exists() {
  if [[ `command -v $1 2>&1` ]]; then
    echo "$1"
  fi
}

alias nbp="nano ~/.bash_profile"
alias gg="git grep"
alias gb="git branch"
alias gc="git checkout"
alias gd="git diff"
alias gs="git status"
alias gcm="git checkout master"
alias amend="git commit --amend"
alias ginc="git commit -am 'inc'"
alias pick="git cherry-pick"
alias show="git show"
alias stash="git stash"

function grb() { git rebase -i HEAD~$1; }
function pop {
  if [ $1 ]; then
    git stash pop stash@{$1};
  else
    git stash pop;
  fi
}

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
elif [[ `command_exists brew` && -f `brew --prefix`/etc/bash_completion ]]; then
  . `brew --prefix`/etc/bash_completion
fi

if [[ `command_exists go` && -n $GOPATH ]]; then
  eval `go env`
  export PATH="$PATH:$GOPATH/bin"
  alias gogo="cd $GOPATH/src"
fi
