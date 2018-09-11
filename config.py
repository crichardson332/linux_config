#!/usr/bin/env python

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
    if not os.path.exists(user_home + '/.vim/pack/crich/start/vim-airline'):
        os.system("git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/crich/start/vim-airline")
    if not os.path.exists(user_home + '/.vim/bundle/vim-airline-themes'):
        os.system("git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes")
    if not os.path.exists(user_home + '/.vim/bundle/vim-colors-solarized'):
        os.system("git clone git://github.com/altercation/vim-colors-solarized.git $HOME/.vim/bundle/vim-colors-solarized")
    if not os.path.exists(user_home + '/.vim/bundle/tabular'):
        os.system("git clone git://github.com/godlygeek/tabular.git $HOME/.vim/bundle/tabular")
    if not os.path.exists(user_home + '/.vim/bundle/ctrlp.vim'):
        os.system("git clone https://github.com/kien/ctrlp.vim.git $HOME/.vim/bundle/ctrlp.vim")
    if not os.path.exists(user_home + '/.vim/bundle/vim-fugitive'):
        os.system("git clone https://github.com/tpope/vim-fugitive.git $HOME/.vim/bundle/vim-fugitive")
    if not os.path.exists(user_home + '/.vim/bundle/vim-surround'):
        os.system("git clone https://github.com/tpope/vim-surround.git $HOME/.vim/bundle/vim-surround")
    if not os.path.exists(user_home + '/.vim/pack/crich/start/commentary'):
        os.system("git clone https://tpope.io/vim/commentary.git $HOME/.vim/pack/crich/start/commentary")

    shutil.copy(script_dir + '/vimrc', user_home + '/.vimrc')

def install_bashrc():
    shutil.copy(script_dir + '/prompt.bash', user_home + '/.prompt.bash')
    if platform == "linux" or platform == "linux2":
        shutil.copy(script_dir + '/bashrc', user_home + '/.bashrc')
    elif platform == "darwin":
        shutil.copy(script_dir + '/bashrc_darwin', user_home + '/.bashrc')
        shutil.copy(script_dir + '/bash_profile', user_home + '/.bash_profile')
    else:
        return

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

    # if not os.path.isdir(args.out_dir):
    #     print("Output directory doesn't exist: %s" % args.out_dir)
    #     return -1

    # # Get this script's current directory
    # this_dir = os.path.dirname(os.path.realpath(__file__))

    # # Copy the cmake project template to the output directory
    # dst_dir = args.out_dir + "/" + args.project_name
    # try:
    #     shutil.copytree(this_dir + "/templates/cmake-project", dst_dir)
    # except OSError:
    #     print('The destination directory already exists: %s' % dst_dir)
    #     print('Choose a new output directory or remove the existing directory.')
    #     return -1
    
    # # Search and replace project name over all project files
    # for dname, dirs, files in os.walk(dst_dir):
    #     for fname in files:
    #         fpath = os.path.join(dname, fname)
    #         with open(fpath) as f:
    #             s = f.read()
    #             s = s.replace("(>>>PROJECT_NAME<<<)", args.project_name)
    #         with open(fpath, "w") as f:
    #             f.write(s)

    # # Rename the ./include/cmake-project to the appropriate project
    # # name
    # os.rename(dst_dir+"/include/cmake-project",
    #           dst_dir+"/include/" + args.project_name)

    return 0

if __name__ == '__main__':
    sys.exit(main())
