set -x BROWSER wslview
set -x SHELL fish

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Unified config
set -gx REPOSITORIES $HOME/Repositories
source $REPOSITORIES/dotfiles/config.fish
