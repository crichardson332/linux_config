# check if ssh session
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SESSION_TYPE=ssh
fi

# set display to remote (0) during ssh session
if [ $SESSION_TYPE="ssh" ]; then
  export DISPLAY=":0"
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colored manpages
if [ -f ~/.bash_mancolors ]; then
    . ~/.bash_mancolors
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi  
fi

# dircolors for solarized
eval `dircolors ~/.dircolors/dircolors-solarized/dircolors.ansi-dark`

# prompt
#export PS1="\n\[\e[31m\][\[\e[m\]\t\[\e[31m\]]\[\e[m\] \w/\n\[\e[36m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\]\\$ "

# aliases
alias rm='safe-rm'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias l='ls -lh'
alias lll='ls -lh'
alias la='ls -lsah'
alias rlg='source ~/.bashrc'
alias gits='git status'
alias bd='./build_scripts/build'
alias grep='grep --color=auto'
alias cld='cdl'
alias bdl='./build_scripts/lite_build'

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
  grep -Pzo '$1.*\n.*$2' "${@:2}"
}

function llg() {
  vim "$(find $1* -type f -printf "%C@ %p\n" | sort | tail -n 1 | cut -d " " -f 2-)"
}

function vimfind() {
  vim $( find $@ )
}

function cdu() {
  if [[ "$#" -gt 0 ]] ; then
    cd $(printf "%0.s../" $(seq 1 $1 ));
    ls -lh
  fi
}

# Set prompt
source ~/.prompt.bash

