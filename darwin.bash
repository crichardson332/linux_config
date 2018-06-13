#!/bin/bash

brew install gtest curl git python vim safe-rm tmux grep coreutils trash-cli ninja tree

BASH_PROFILE=$HOME"/.bash_profile"

# create config files
touch $BASH_PROFILE
cp bash_profile $BASH_PROFILE
