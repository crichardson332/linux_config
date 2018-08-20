#!/bin/bash

# source OS specific scripts
if [[ "$OSTYPE" == "darwin"* ]] ; then
  source darwin.bash
elif [[ "$OSTYPE" == "linux-gnu" ]] ; then
  source linux-gnu.bash
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
if [ ! -d $HOME"/.vim/bundle/vim-vinegar" ]; then
git clone https://github.com/tpope/vim-vinegar.git $HOME/.vim/bundle/vim-vinegar
vim -u NONE -c "helptags vim-vinegar/doc" -c q
fi
if [ ! -d $HOME"/.vim/pack/crich/start/commentary" ]; then
git clone https://tpope.io/vim/commentary.git $HOME/.vim/pack/crich/start/commentary
vim -u NONE -c "helptags commentary/doc" -c q
fi

# dircolors
if [ ! -d $HOME"/.dircolors/dircolors-solarized" ]; then
git clone https://github.com/seebi/dircolors-solarized.git $HOME/.dircolors/dircolors-solarized
fi

# create config files
touch $BASHRC
touch $BASHPROMPT
touch $VIMRC
cp bashprompt $BASHPROMPT
cp vimrc $VIMRC

# source OS specific bash setup scripts
if [[ "$OSTYPE" == "darwin"* ]] ; then
  cp bashrc_darwin $BASHRC
  source $BASH_PROFILE
elif [[ "$OSTYPE" == "linux-gnu" ]] ; then
  cp bashrc $BASHRC
  source $BASHRC
fi
