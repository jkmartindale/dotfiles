#!/usr/bin/env bash

REPOSITORIES=$HOME/Repositories
GH_USERNAME=jkmartindale
NAME="James Martindale"

# TODO: better messaging about Touch ID setup
open "x-apple.systempreferences:com.apple.preferences.password"
cat <(echo "auth sufficient pam_tid.so") /etc/pam.d/sudo | sudo tee /etc/pam.d/sudo

# Homebrew + fish
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install fish
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# Load dotfiles repo
git clone https://github.com/jkmartindale/dotfiles.git $REPOSITORIES/dotfiles
cd $REPOSITORIES/dotfiles

# TODO: actual package install code goes here lol

# Git
GH_EMAIL="$(curl -s https://api.github.com/users/$GH_USERNAME | jq '.id')+$GH_USERNAME@users.noreply.github.com"
ssh-keygen -t ed25519 -C $GH_EMAIL
pbcopy < ~/.ssh/id_ed25519.pub
open https://github.com/settings/ssh/new
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
cd $REPOSITORIES/dotfiles
git remote set-url origin git@github.com:jkmartindale/dotfiles.git
git config --global user.name $NAME
git config --global user.email $GH_EMAIL

mkdir -p ~/Library/KeyBindings
ln -sf $REPOSITORIES/dotfiles/macOS/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
ln -sf $REPOSITORIES/dotfiles/macOS/config.fish ~/.config/fish/config.fish
ln -sf $REPOSITORIES/dotfiles/starship.toml ~/.config/starship.toml