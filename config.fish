if status is-interactive
    starship init fish | source
end

ssh-add -A 2>/dev/null

set -x EDITOR code

alias config="$EDITOR ~/.config/fish/config.fish"
