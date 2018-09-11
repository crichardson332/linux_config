#!/bin/bash

# source OS specific scripts
if [[ "$OSTYPE" == "darwin"* ]] ; then
  # install command line utils, homebrew, and python
  xcode-select --install
  which -s brew
  if [[ $? != 0 ]] ; then
      # Install Homebrew
      echo "Installing Homebrew."
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
      echo "Updating Homebrew."
  fi
  brew update
  brew upgrade
  brew install gtest curl git python vim safe-rm tmux grep coreutils trash ninja tree
  touch $HOME/.bash_profile

elif [[ "$OSTYPE" == "linux-gnu" ]] ; then
  # remap caps lock to ctrl
  /usr/bin/setxkbmap -option caps:ctrl_modifier

  # terminator
  touch $HOME/.config/terminator/config

  # Debian
  if which apt-get &> /dev/null; then
    echo "This is Ubuntu. Using dpkg."
    # install packages, including vim8 from ppa
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt-get update
    sudo apt-get install build-essential libgtest-dev curl terminator git python vim safe-rm openssh-server tmux vim trash-cli
  
  # OpenSuse, Mandriva, Fedora, CentOs, ecc. (with rpm)
  elif which rpm &> /dev/null; then
    echo "This is Red Hat / CentOS. Using rpm."
    sudo yum install rh-python36 build-essential libgtest-dev curl terminator git python safe-rm openssh-server tmux vim trash-cli
  
  # ArchLinux (with pacman)
  elif which pacman &> /dev/null; then
    echo "This is ArchLinux. Using pacman."
    pacman -S python build-essential libgtest-dev curl terminator git vim safe-rm openssh-server tmux trash-cli
  else
    echo "Can't determine operating system or package system."
    exit
  fi
fi

# vim pathogen
mkdir -p $HOME/.vim/autoload ~/.vim/bundle
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# create folders if they dont exist
if [ ! -d $HOME"/.vim" ]; then
  mkdir -p $HOME/.vim
fi
if [ ! -d $HOME"/.vim/pack/crich/start/vim-airline" ]; then
git clone https://github.com/vim-airline/vim-airline $HOME/.vim/pack/dist/start/vim-airline
vim -u NONE -c "helptags vim-airline/doc" -c q
fi
if [ ! -d $HOME"/.vim/bundle/vim-airline-themes" ]; then
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
vim -u NONE -c "helptags vim-airline-themes/doc" -c q
fi

if [ ! -d $HOME"/.dircolors" ]; then
  mkdir -p $HOME/.dircolors
fi

# run python setup
ScriptDir="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )";
python $ScriptDir/config.py --all
