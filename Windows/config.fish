# Variables
set -x BROWSER wslview

# Homebrew
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fish_add_path ~/.local/bin

# Unified config
set -gx REPOSITORIES $USERPROFILE/Repositories
source $REPOSITORIES/dotfiles/config.fish
