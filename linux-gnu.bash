#!/bin/bash

# add apt repo for vim 8.0
sudo add-apt-repository ppa:jonathonf/vim

sudo apt-get update
sudo apt-get install build-essential libgtest-dev curl terminator git python vim safe-rm openssh-server tmux vim trash-cli

if [ ! -d $HOME"/.config/terminator" ]; then
  mkdir -p $HOME/.config/terminator
fi

TERMINATOR_CONFIG=$HOME"/.config/terminator/config"

# create config files
touch $TERMINATOR_CONFIG
cp terminator_config $TERMINATOR_CONFIG
