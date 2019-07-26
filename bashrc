# source ssh bashrc file with basic aliases and functions
source $HOME/.bashrc_ssh

# platform specific config
if [[ $OSTYPE == "linux-gnu" ]]; then
    # check if ssh session
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
      export DISPLAY=":0"
    fi

    # append to the history file, don't overwrite it
    shopt -s histappend

    # external scripts
    source ${HOME}/.docker.bash

    # dircolors for colorscheme
    # eval "$(dircolors "$HOME/.dircolors/dircolors-solarized/dircolors.ansi-dark")"
    eval "$(dircolors "$HOME/.dircolors/dircolors-gruvbox/gruvbox-dark.dircolors")"

elif [[ $OSTYPE == "darwin"* ]]; then
    function focus_follows_mouse() {
      defaults write com.apple.Terminal FocusFollowsMouse -string YES
    }
fi

# python
export PYTHONPATH="/usr/local/Cellar/python/3.7.0/bin/python3:$PYTHONPATH"
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# cross platform aliases
alias tr='trash'

# ssh
alias sshvm='ssh -p 2224 chris@127.0.0.1'
alias sshvmd='ssh -p 2226 chris@127.0.0.1'
alias sshlnx='ssh crichardson@192.168.90.207'

# git
git config --global user.name "Christopher Richardson"
git config --global user.email christopher.richardson@gtri.gatech.edu
git config --global alias.nicelog 'log --decorate --oneline --graph'
git config --global alias.biglog 'log --decorate --graph'
git config --global push.default simple
git config --global fetch.prune true
git config --global fetch.prune true
git config --global core.excludesfile ~/.gitignore
# git aliases
git config --global alias.su 'submodule update'
git config --global alias.sui 'submodule update --init'
git config --global alias.sum 'submodule update --remote'
git config --global alias.suim 'submodule update --init --remote'
git config --global alias.sur 'submodule update --recursive'
git config --global alias.suri 'submodule update --recursive --init'
git config --global alias.surm 'submodule update --recursive --remote'
git config --global alias.surim 'submodule update --recursive --init --remote'
# ctags
#git rev-list BRANCH | while read rev; do git grep "REGEX" $rev; done

# Editor
export VISUAL=vim
export EDITOR="$VISUAL"

# grep and pipe to less with color
function greplc ()
{
  grep "$@" -r --color=always | less -R
}
# grep across multiple lines
#GREP2L_HELP="
#  grep2l pattern1 pattern2 [<options>]
#  Options:
#  -h      Print this message
#  "
function grep2l ()
{
  grep -Pzo "$1.*\\n.*$2" "${@:2}"
}

function llg() {
  vim "$(find $1* -type f -printf "%C@ %p\n" | sort | tail -n 1 | cut -d " " -f 2-)"
}

# vim functions
function vimfind() {
  vim "$( find "$@" )"
}
function vimcpp() {
  vim $(find -P . -not -path '*/\.*' -not -path '*/build*' -type f -regex '.*\.\(cpp\|hpp\|h\|cc\|c\)$')
}
function vimchanged() {
  vim $(git diff --name-only HEAD^ HEAD)
}

function change_occurrences_of_name() {
  HELP="Change all occurrences of OLDNAME to NEWNAME in all files at or below the current
directory, recursively. Symbolic links are not followed.

Usage:
  change_occurrences_of_name OLDNAME NEWNAME
  "
  if [ -z "$1" ] ; then
    echo "$HELP"
  elif [ -z "$2" ] ; then
    echo "$HELP"
  else
    find . -type f -not -path '*/\.*' -exec sed -i "s/$1/$2/g" {} \;
  fi
}

function purge_scrimmage_paths() {
  export SCRIMMAGE_DATA_PATH=""
  export SCRIMMAGE_CONFIG_PATH=""
  export SCRIMMAGE_PLUGIN_PATH=""
  export SCRIMMAGE_MISSION_PATH=""
}

# cmake
function cmake_find_package() {
  cmake --find-package -DNAME="$1" -DCOMPILER_ID=GNU -DMODE=EXIST -DLANGUAGE=CXX
}

# shellcheck source=/dev/null
source ~/.prompt.bash

if [ -f ~/.scrimmage/setup.bash ]; then
  # shellcheck source=/dev/null
  source ~/.scrimmage/setup.bash
fi

if [ -f /opt/ros/kinetic/setup.bash ]; then
  # shellcheck source=/dev/null
  source /opt/ros/kinetic/setup.bash
fi

# GTRI
# SSH_ENV=$HOME/.ssh/environment
# function start_agent {
#     echo "Initializing new SSH agent..."
#     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
#     echo succeeded
#     chmod 600 "${SSH_ENV}"
#     . "${SSH_ENV}" > /dev/null
#     /usr/bin/ssh-add
# }
# if [ -f "${SSH_ENV}" ]; then
#     . "${SSH_ENV}" > /dev/null
#     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#         start_agent;
#     }
# else
#     start_agent;
# fi

# docker exec -it uav_i386-bees_integration_1 /bin/bash

# tab completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# copy bashrc over ssh
# function sshb() {
#   scp $HOME/.bashrc_ssh $1:/tmp/.bashrc_temp > /dev/null
#   ssh -t $1 "bash --rcfile /tmp/.bashrc_temp ; rm /tmp/.bashrc_temp"
# }

function sshs() {
        ssh $@ "cat > /tmp/.bashrc_temp" < ~/.bashrc_ssh
        ssh -t $@ "bash --rcfile /tmp/.bashrc_temp ; rm /tmp/.bashrc_temp"
}

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
