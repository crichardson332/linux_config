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
    # TODO fix vim-plug's gruvbox install
    if not os.path.exists(user_home + '/.vim/pack/crich/start/gruvbox'):
        os.system("git clone https://github.com/morhetz/gruvbox.git $HOME/.vim/pack/crich/start/gruvbox")

    shutil.copy(script_dir + '/vimrc', user_home + '/.vimrc')
    os.system("vim +PlugInstall +qall")


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
        shutil.copy(script_dir + '/config/terminator/config', user_home + '/.config/terminator/config')
    elif platform == "darwin":
        pass
        #print("macOS detected: not installing terminator.")
    else:
        return
    pass

def install_i3():
    if platform == "linux" or platform == "linux2":
        if not os.path.exists(user_home + '/.config/i3'):
            os.makedirs(user_home + '/.config/i3')
        shutil.copy(script_dir + '/config/i3/config', user_home + '/.config/i3/config')
    elif platform == "darwin":
        print("macOS detected: not installing i3.")
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
    if args.fzf or args.all:
        install_fzf()

    if not os.path.exists(user_home + '/.dircolors'):
        os.mkdir(user_home + '/.dircolors')

    if not os.path.exists(user_home + '/.dircolors/dircolors-solarized'):
        os.system("git clone https://github.com/seebi/dircolors-solarized.git $HOME/.dircolors/dircolors-solarized")

    shutil.copy(script_dir + '/gitignore', user_home + '/.gitignore')

    return 0

if __name__ == '__main__':
    sys.exit(main())
