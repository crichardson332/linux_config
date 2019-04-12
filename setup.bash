#!/bin/bash

# source OS specific scripts
if [[ "$OSTYPE" == "darwin"* ]] ; then
  # install command line utils, homebrew, and python
  xcode-select --install

  if ! command -v brew &> /dev/null; then
      # Install Homebrew
      echo "Installing Homebrew."
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  # HOMEBREW_NO_AUTO_UPDATE=1 brew install gtest git python python3 vim safe-rm tmux grep coreutils trash ninja tree clang-format gnu-sed ctags --with-default-names
  brew install gtest git python python3 vim safe-rm tmux grep coreutils trash ninja tree clang-format gnu-sed ctags --with-default-names
  touch "$HOME/.bash_profile"

elif [[ "$OSTYPE" == "linux-gnu" ]] ; then
  # remap caps lock to ctrl
  /usr/bin/setxkbmap -option caps:ctrl_modifier

  # terminator
  touch "$HOME/.config/terminator/config"

  # Debian
  if command -v apt-get &> /dev/null; then
    echo "This is Ubuntu. Using dpkg."
    # install packages, including vim8 from ppa
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt-get update xkbset
    sudo apt-get install build-essential libgtest-dev curl htop terminator git cmake ninja python python3 python3-pip vim safe-rm openssh-server tmux vim trash-cli tree ctags i3 numlockx scrot nitrogen xkbset xdotool

  # OpenSuse, Mandriva, Fedora, CentOs, ecc. (with rpm)
  elif command -v rpm &> /dev/null; then
    echo "This is Red Hat / CentOS. Using rpm."
    sudo yum install rh-python36 build-essential libgtest-dev curl terminator git python safe-rm openssh-server tmux vim trash-cli

  # ArchLinux (with pacman)
  elif command -v pacman &> /dev/null; then
    echo "This is ArchLinux. Using pacman."
    pacman -S python build-essential libgtest-dev curl terminator git vim safe-rm openssh-server tmux trash-cli
  else
    echo "Can't determine operating system or package system."
    exit
  fi
fi

# vim pathogen
if [ ! -f "$HOME/.vim/autoload/pathogen.vim" ]; then
  mkdir -p "$HOME/.vim/autoload ~/.vim/bundle"
  curl -LSso "$HOME/.vim/autoload/pathogen.vim" https://tpo.pe/pathogen.vim
fi

# ctags vim
mkdir -p "$HOME/.git_template/hooks"
cp ./hooks/* "$HOME/.git_template/hooks"

# create config folders
mkdir -p "$HOME/.vim"
mkdir -p "$HOME/.dircolors"

# run python setup
pip3 install gitpython
ScriptDir="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )";
python3 "$ScriptDir/config.py" --all

# source bash config
if [[ "$OSTYPE" == "darwin"* ]] ; then
  source "$HOME/.bash_profile"
else
  source "$HOME/.bashrc"
fi
