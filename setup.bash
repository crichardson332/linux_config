#!/bin/bash

# add apt repo for vim 8.0
sudo add-apt-repository ppa:jonathonf/vim

sudo apt-get update
sudo apt-get install build-essential libgtest-dev curl terminator git python vim safe-rm openssh-server tmux vim

if [ ! -d $HOME"/.config/terminator" ]; then
  mkdir -p $HOME/.config/terminator
fi

if [ ! -d $HOME"/.vim" ]; then
  mkdir -p $HOME/.vim
fi

if [ ! -d $HOME"/.dircolors" ]; then
  mkdir -p $HOME/.dircolors
fi

BASHRC=$HOME"/.bashrc"
BASHPROMPT=$HOME"/.prompt.bash"
VIMRC=$HOME"/.vimrc"
TERMINATOR_CONFIG=$HOME"/.config/terminator/config"

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

# dircolors
if [ ! -d $HOME"/.dircolors/dircolors_solarized" ]; then
git clone https://github.com/seebi/dircolors-solarized.git $HOME/.dircolors/dircolors_solarized
fi

# create config files
touch $BASHRC
touch $BASHPROMPT
touch $VIMRC
touch $TERMINATOR_CONFIG
cp bashrc $BASHRC
cp bashprompt $BASHPROMPT
cp vimrc $VIMRC
cp terminator_config $TERMINATOR_CONFIG

source $BASHRC
