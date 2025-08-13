#!/usr/bin/env fish

eval (brew shellenv)
fish_add_path ~/.local/bin # pipx and Linuxbrew

# Scripts etc. don't need all my laziness enablers
if not status is-interactive
    exit
end

# Variables
set -x EDITOR code --wait
set -x SHELL (which fish)

# Shell experience
eval (keychain --eval 2> /dev/null) # relies on SHELL variable for correct output
starship init fish | source
bind \cH backward-kill-word
function fish_title
    # So I don't get confused when I launch from PowerShell tab and the console theme is unchanged
    echo [fish] (basename $PWD)
end

# Aliases/functions
alias config="$EDITOR ~/.config/fish/config.fish"
alias brewlist='brew leaves | xargs brew deps --include-build --tree' # https://stackoverflow.com/a/61928483/3427178

# Completions
if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end
if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

# Python
pyenv init - fish | source

# Rust
fish_add_path ~/.cargo/bin
set -gx RUSTC_WRAPPER (which sccache)

# Employer-specific config I don't want to publish
if test -e ~/.config/fish/work.fish
    source ~/.config/fish/work.fish
end
