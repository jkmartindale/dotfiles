ssh-add -A 2>/dev/null

if status is-interactive
    # Variables
    set -x EDITOR code
    set -x SHELL (which fish)

    # Shell experience
    starship init fish | source
    bind \cH backward-kill-word

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
end
