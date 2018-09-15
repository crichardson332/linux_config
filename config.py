#!/usr/bin/env python3
import os
from os.path import expanduser
import shutil
import sys
import argparse
import git
from sys import platform

# global home var
user_home = ''
script_dir = os.path.dirname(os.path.realpath(__file__))

def install_vim():
    if not os.path.exists(user_home + '/.vim/pack/crich/start'):
        os.makedirs(user_home + '/.vim/pack/crich/start')

    # pathogen
    if not os.path.exists(user_home + '/.vim/autoload/pathogen.vim'):
        os.system("curl -LSso \"$HOME/.vim/autoload/pathogen.vim\" https://tpo.pe/pathogen.vim")

    # plugins
    if not os.path.exists(user_home + '/.vim/pack/crich/start/ale'):
        os.system("git clone https://github.com/w0rp/ale.git ~/.vim/pack/crich/start/ale")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/commentary'):
        os.system("git clone https://tpope.io/vim/commentary.git $HOME/.vim/pack/crich/start/commentary")
    if not os.path.exists(user_home + '/.vim/bundle/ctrlp.vim'):
        os.system("git clone https://github.com/kien/ctrlp.vim.git $HOME/.vim/bundle/ctrlp.vim")
    if not os.path.exists(user_home + '/.vim/bundle/tabular'):
        os.system("git clone git://github.com/godlygeek/tabular.git $HOME/.vim/bundle/tabular")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/vim-airline'):
        os.system("git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/crich/start/vim-airline")
    if not os.path.exists(user_home + '/.vim/bundle/vim-airline-themes'):
        os.system("git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes")
    if not os.path.exists(user_home + '/.vim/bundle/vim-colors-solarized'):
        os.system("git clone git://github.com/altercation/vim-colors-solarized.git $HOME/.vim/bundle/vim-colors-solarized")
    if not os.path.exists(user_home + '/.vim/bundle/vim-fugitive'):
        os.system("git clone https://github.com/tpope/vim-fugitive.git $HOME/.vim/bundle/vim-fugitive")
    if not os.path.exists(user_home + '/.vim/bundle/vim-surround'):
        os.system("git clone https://github.com/tpope/vim-surround.git $HOME/.vim/bundle/vim-surround")

    shutil.copy(script_dir + '/vimrc', user_home + '/.vimrc')

def install_bashrc():
    shutil.copy(script_dir + '/prompt.bash', user_home + '/.prompt.bash')
    shutil.copy(script_dir + '/bashrc', user_home + '/.bashrc')
    if platform == "darwin":
        shutil.copy(script_dir + '/bash_profile', user_home + '/.bash_profile')

def install_terminator():
    if platform == "linux" or platform == "linux2":
        shutil.copy(script_dir + '/terminator_config', user_home + '/.config/terminator/config')
    elif platform == "darwin":
        pass
        #print("macOS detected: not installing terminator.")
    else:
        return
    pass

def main():
    # cant run as root
    env = os.environ.copy()
    global user_home
    # The HOME variable doesn't exist if running as root
    try:
        user_home = env['HOME']
    except KeyError:
        print("ERROR: Cannot run setup.py as root.")
        return 1
    if 'root' in user_home:
        print("ERROR: Cannot run setup.py as root.")
        return 1

    # arguments
    parser=argparse.ArgumentParser(description='Command line setup script.')
    parser.add_argument('-a','--all', action='store_true', default=False,
                        help='Install all configs')
    parser.add_argument('-v','--vim', action='store_true', default=False,
                        help='Install vim plugins and vimrc')
    parser.add_argument('-b','--bashrc', action='store_true', default=False,
                        help='Install bashrc and prompt')
    parser.add_argument('-t','--terminator', action='store_true', default=False,
                        help='Install terminator config')
    args = parser.parse_args()

    if args.vim or args.all:
        install_vim()
    elif args.bashrc or args.all:
        install_bashrc()
    elif args.terminator or args.all:
        install_terminator()
    else:
        print("No install options chosen. Doing nothing. See --help for options.")

    if not os.path.exists(user_home + '/.dircolors'):
        os.mkdir(user_home + '/.dircolors')

    if not os.path.exists(user_home + '/.dircolors/dircolors-solarized'):
        os.system("git clone https://github.com/seebi/dircolors-solarized.git $HOME/.dircolors/dircolors-solarized")

    return 0

if __name__ == '__main__':
    sys.exit(main())
