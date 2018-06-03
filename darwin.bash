#!/bin/bash

brew install gtest curl git python vim safe-rm tmux grep coreutils trash-cli ninja tree

if [ ! -d $HOME"/.vim" ]; then
  mkdir -p $HOME/.vim
fi

if [ ! -d $HOME"/.dircolors" ]; then
  mkdir -p $HOME/.dircolors
fi

BASH_PROFILE=$HOME"/.bash_profile"
BASHRC=$HOME"/.bashrc"
BASHPROMPT=$HOME"/.prompt.bash"
VIMRC=$HOME"/.vimrc"

# vim pathogen
mkdir -p $HOME/.vim/autoload ~/.vim/bundle
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# vim plugins
if [ ! -d $HOME"/.vim/bundle/vim-colors-solarized" ]; then
  git clone git://github.com/altercation/vim-colors-solarized.git $HOME/.vim/bundle/vim-colors-solarized
fi
if [ ! -d $HOME"/.vim/bundle/nerdtree" ]; then
  git clone https://github.com/scrooloose/nerdtree.git $HOME/.vim/bundle/nerdtree
fi
if [ ! -d $HOME"/.vim/bundle/tabular" ]; then
git clone git://github.com/godlygeek/tabular.git $HOME/.vim/bundle/tabular
fi
if [ ! -d $HOME"/.vim/bundle/ctrlp.vim" ]; then
git clone https://github.com/kien/ctrlp.vim.git $HOME/.vim/bundle/ctrlp.vim
fi
if [ ! -d $HOME"/.vim/bundle/vim-fugitive" ]; then
git clone https://github.com/tpope/vim-fugitive.git $HOME/.vim/bundle/vim-fugitive
vim -u NONE -c "helptags vim-fugitive/doc" -c q
fi
if [ ! -d $HOME"/.vim/bundle/vim-surround" ]; then
git clone https://github.com/tpope/vim-surround.git $HOME/.vim/bundle/vim-surround
vim -u NONE -c "helptags vim-surround/doc" -c q
fi
if [ ! -d $HOME"/.vim/bundle/vim-bufferline" ]; then
git clone https://github.com/bling/vim-bufferline $HOME/.vim/bundle/vim-bufferline
vim -u NONE -c "helptags vim-bufferline/doc" -c q
fi

# dircolors
if [ ! -d $HOME"/.dircolors/dircolors-solarized" ]; then
git clone https://github.com/seebi/dircolors-solarized.git $HOME/.dircolors/dircolors-solarized
fi

# create config files
touch $BASH_PROFILE
touch $BASHRC
touch $BASHPROMPT
touch $VIMRC
cp bash_profile $BASH_PROFILE
cp bashrc_darwin $BASHRC
cp bashprompt $BASHPROMPT
cp vimrc $VIMRC

source $BASH_PROFILE
