#!/usr/bin/env bash

# Like the rest of this repo, this resembles more of a checklist or notes than an actually tested script

# Assume dotfiles already planted in Windows side
export REPOSITORIES=$(wslpath $(wslvar USERPROFILE))/Repositories

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
echo -ne '\n' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> /home/$(whoami)/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/$(whoami)/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew analytics off

# Python
sudo apt install -y libsqlite3-dev
brew install pyenv tcl-tk # brewed pyenv didn't detect tk-dev but detected brewed tcl-tk
pyenv install 3
echo >> /home/$(whoami)/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> /home/$(whoami)/.bashrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/$(whoami)/.bashrc
echo 'eval "$(pyenv init - bash)"' >> /home/$(whoami)/.bashrc
eval "$(pyenv init - bash)"
pip install --upgrade pip

# Install global packages.toml

# Install Windows packages.toml

# Post-install
fish -C "source $REPOSITORIES/dotfiles/Windows/postinstall.fish"
