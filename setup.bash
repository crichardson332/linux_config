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
  brew install gtest git python python3 vim safe-rm tmux grep coreutils trash ninja tree clang-format gnu-sed ctags
  touch "$HOME/.bash_profile"

elif [[ "$OSTYPE" == "linux-gnu" ]] ; then
  # remap caps lock to ctrl
  # /usr/bin/setxkbmap -option caps:ctrl_modifier
  xset r rate 250 60

  # terminator
  touch "$HOME/.config/terminator/config"

  # vim-plug
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # Debian
  if command -v apt-get &> /dev/null; then
    echo "This is Ubuntu. Using dpkg."
    # sudo apt-get update xkbset
    sudo apt-get install build-essential libgtest-dev curl htop terminator git cmake ninja-build python python3 python3-pip vim safe-rm openssh-server tmux vim trash-cli tree ctags i3 numlockx scrot nitrogen xkbset xdotool xbacklight rofi
fi

# create config folders
mkdir -p "$HOME/.vim"
mkdir -p "$HOME/.dircolors"

# run python setup
pip3 install gitpython
SCRIPT_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )";
python3 "$SCRIPT_DIR/customize.py" --all

# source bash config
if [[ "$OSTYPE" == "darwin"* ]] ; then
  source "$HOME/.bash_profile"
else
  source "$HOME/.bashrc"
fi
