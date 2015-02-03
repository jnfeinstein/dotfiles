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

function grb() { git rebase --preserve-merges -i HEAD~$1; }
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

  function bgodoc() {
    echo "Starting gdoc server at localhost:6060";
    godoc -http=:6060;
  }
fi

if [[ `command_exists postgres` ]]; then
  alias bpostgres="postgres -D /usr/local/var/postgres";
fi

if [[ `command_exists screen` ]]; then
  function bscreen() {
    if [[ $# -eq 0 ]]; then
      echo "No arguments provided";
      echo "Usage: bscreen <SESSION_NAME>";
      return;
    fi

    if [ $(screen -list | grep $1 | wc -l) -gt "0" ]; then
      screen -d -r $1;
    else
      screen -S $1 bash -l;
    fi
  }
fi

if [[ `command_exists mongo` ]]; then
  function mongoc() {
    if [ "$1" == "clean" ]; then
      echo "Cleaning mongod lockfile";
      rm /usr/local/var/mongodb/mongod.lock;
    elif [ "$1" == "reload" ]; then
      echo "Reloading mongod";
      launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb24.plist;
      launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb24.plist;
    fi
  }
fi
