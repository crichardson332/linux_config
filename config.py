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

    # # pathogen
    # if not os.path.exists(user_home + '/.vim/autoload/pathogen.vim'):
    #     os.system("curl -LSso \"$HOME/.vim/autoload/pathogen.vim\" https://tpo.pe/pathogen.vim")

    # plugins
    if not os.path.exists(user_home + '/.vim/pack/crich/start/ale'):
        os.system("git clone https://github.com/w0rp/ale.git ~/.vim/pack/crich/start/ale")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/commentary'):
        os.system("git clone https://tpope.io/vim/commentary.git $HOME/.vim/pack/crich/start/commentary")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/SyntaxRange'):
        os.system("git clone https://github.com/vim-scripts/SyntaxRange $HOME/.vim/pack/crich/start/SyntaxRange")

    if not os.path.exists(user_home + '/.vim/pack/crich/start/tabular'):
        os.system("git clone git://github.com/godlygeek/tabular $HOME/.vim/pack/crich/start/tabular")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/vim-airline'):
        os.system("git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/crich/start/vim-airline")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/vim-airline-themes'):
        os.system("git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/pack/crich/start/vim-airline-themes")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/vim-colors-solarized'):
        os.system("git clone git://github.com/altercation/vim-colors-solarized.git $HOME/.vim/pack/crich/start/vim-colors-solarized")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/vim-fugitive'):
        os.system("git clone https://github.com/tpope/vim-fugitive $HOME/.vim/pack/crich/start/vim-fugitive")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/vim-orgmode'):
        os.system("git clone https://github.com/jceb/vim-orgmode $HOME/.vim/pack/crich/start/vim-orgmode")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/vim-repeat'):
        os.system("git clone https://github.com/tpope/vim-repeat $HOME/.vim/pack/crich/start/vim-repeat")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/vim-speeddating'):
        os.system("git clone https://github.com/tpope/vim-speeddating $HOME/.vim/pack/crich/start/vim-speeddating")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/vim-surround'):
        os.system("git clone https://github.com/tpope/vim-surround $HOME/.vim/pack/crich/start/vim-surround")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/vim-vinegar'):
        os.system("git clone https://github.com/tpope/vim-vinegar $HOME/.vim/pack/crich/start/vim-vinegar")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/utl.vim'):
        os.system("git clone https://github.com/vim-scripts/utl.vim $HOME/.vim/pack/crich/start/utl.vim")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/gruvbox'):
        os.system("git clone https://github.com/morhetz/gruvbox.git $HOME/.vim/pack/crich/start/gruvbox")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/gutentags'):
        os.system("git clone https://github.com/ludovicchabant/vim-gutentags.git $HOME/.vim/pack/crich/start/gutentags")

    shutil.copy(script_dir + '/vimrc', user_home + '/.vimrc')

def install_bashrc():
    shutil.copy(script_dir + '/prompt.bash', user_home + '/.prompt.bash')
    shutil.copy(script_dir + '/bashrc_ssh', user_home + '/.bashrc_ssh')
    shutil.copy(script_dir + '/bashrc', user_home + '/.bashrc')
    if platform == "darwin":
        shutil.copy(script_dir + '/bash_profile', user_home + '/.bash_profile')

def install_terminator():
    if platform == "linux" or platform == "linux2":
        if not os.path.exists(user_home + '/.config/terminator'):
            os.makedirs(user_home + '/.config/terminator')
        shutil.copy(script_dir + '/terminator_config', user_home + '/.config/terminator/config')
    elif platform == "darwin":
        pass
        #print("macOS detected: not installing terminator.")
    else:
        return
    pass

def install_i3():
    if platform == "linux" or platform == "linux2":
        shutil.copy(script_dir + '/config/i3', user_home + '/.config/i3')
    elif platform == "darwin":
        print("macOS detected: not installing i3.")
        pass
    return

def install_kitty():
    if platform == "linux" or platform == "linux2":
        shutil.copy(script_dir + '/config/kitty', user_home + '/.config/kitty')
    elif platform == "darwin":
        print("macOS detected: not installing kitty.")
        pass
    return

def install_fzf():
    if platform == "linux" or platform == "linux2":
        if not os.path.exists(user_home + '/.fzf'):
            os.system("git clone https://github.com/junegunn/fzf.git $HOME/.fzf")
            os.system("~/.fzf/install --all")
    elif platform == "darwin":
            os.system("brew install fzf")
    return

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
    parser.add_argument('-i','--i3', action='store_true', default=False,
                        help='Install i3 config')
    parser.add_argument('-k','--kitty', action='store_true', default=False,
                        help='Install kitty config')
    parser.add_argument('-f','--fzf', action='store_true', default=False,
                        help='Install fzf')
    args = parser.parse_args()

    if args.vim or args.all:
        install_vim()
    if args.bashrc or args.all:
        install_bashrc()
    if args.terminator or args.all:
        install_terminator()
    if args.i3 or args.all:
        install_i3()
    if args.kitty or args.all:
        install_kitty()
    if args.fzf or args.all:
        install_fzf()

    if not os.path.exists(user_home + '/.dircolors'):
        os.mkdir(user_home + '/.dircolors')

    if not os.path.exists(user_home + '/.dircolors/dircolors-solarized'):
        os.system("git clone https://github.com/seebi/dircolors-solarized.git $HOME/.dircolors/dircolors-solarized")

    return 0

if __name__ == '__main__':
    sys.exit(main())
