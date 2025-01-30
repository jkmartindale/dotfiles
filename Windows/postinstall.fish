#!/usr/bin/env fish

# dotfiles
mkdir -p ~/.config/fish
ln -s (wslpath (wslvar USERPROFILE))/Repositories/dotfiles/Windows/config.fish ~/.config/fish/config.fish
ln -s (wslpath (wslvar USERPROFILE))/Repositories/dotfiles/starship.toml ~/.config/starship.toml

# Git
set GH_USERNAME jkmartindale
git config --global user.name (curl -s https://api.github.com/users/$GH_USERNAME | jq '.name')
git config --global user.email (curl -s https://api.github.com/users/$GH_USERNAME | jq '.id')+$GH_USERNAME@users.noreply.github.com
