# platform specific config
if [[ $OSTYPE == "linux-gnu" ]]; then
  # check if ssh session
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    export DISPLAY=":0"
  fi

  # append to the history file, don't overwrite it
  shopt -s histappend

  # relad config
  alias rlg='source ~/.bashrc'
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'

  # remap caps lock
  setxkbmap -layout us -option ctrl:nocaps
elif [[ $OSTYPE == "darwin"* ]]; then
  alias ls='gls --color=auto'
  alias grep='ggrep --color=auto'
  alias dircolors='gdircolors'
  alias rlg='source ~/.bash_profile'
fi

# cross platform config

# dircolors for solarized
eval "$(dircolors "$HOME/.dircolors/dircolors-solarized/dircolors.ansi-dark")"

# cross platform aliases
alias rm='trash'
alias purge='/bin/rm'
alias ll='ls -lh'
alias l='ls -lh'
alias lll='ls -lh'
alias la='ls -lsah'
alias gits='git status'
alias bd='./build_scripts/build'
alias cld='cdl'
alias bdl='./build_scripts/lite_build'
alias gitb='git branch -vv'

# ssh
alias sshvm='ssh -p 3022 chris@127.0.0.1'
alias sshvm3='ssh -p 2223 chris@127.0.0.1'
alias sshvmd='ssh -p 2224 chris@127.0.0.1'
alias sshlnx='ssh crichardson@192.168.90.201'

# git
git config --global user.name "Christopher Richardson"
git config --global user.email christopher.richardson@gtri.gatech.edu
git config --global alias.nicelog 'log --decorate --oneline --graph'
git config --global push.default simple

# Editor
export VISUAL=vim
export EDITOR="$VISUAL"

### useful functions

# cd and ls
function cdl ()
{
  if [ $# == 0 ]
  then
    cd && ls -lh --color=auto
  else
    cd "$1" && ls -lh --color=auto
  fi
}

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

function cdu() {
  if [[ "$#" -gt 0 ]] ; then
    cd $(printf "%0.s../" $(seq 1 $1 ));
    ls -lh
  fi
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

# FIXME because I have to do this :/
function bdx () {
  last3dir=$(basename "$(dirname "$(dirname "$PWD")")")/$(basename "$(dirname "$PWD")")/$(basename "$PWD")
  if [ "$last3dir" == "gtri-bees/srcx/build" ]; then
    cmake .. -G Ninja -DCMAKE_INSTALL_PREFIX=~/gtri-uav-install
  else
    echo "Must be in gtri-bees/srcx/build to run this command!"
  fi
}

function add_dotlocal_to_ldpath() {
  export LD_LIBRARY_PATH="/home/$USER/.local/lib:$LD_LIBRARY_PATH"
  echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
}

function add_gtri-uav-install_to_ldpath() {
  export LD_LIBRARY_PATH="/home/$USER/gtri-uav-install/lib:$LD_LIBRARY_PATH"
  echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
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
