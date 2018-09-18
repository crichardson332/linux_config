source ~/.bashrc

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# this allow brew install without auto updates/upgrades every time
export HOMEBREW_NO_AUTO_UPDATE=1
