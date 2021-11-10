if status is-interactive
    starship init fish | source
end

set -x EDITOR code

alias config="$EDITOR ~/.config/fish/config.fish"
