ssh-add -A 2>/dev/null

set -x EDITOR code

alias config="$EDITOR ~/.config/fish/config.fish"

if status is-interactive
    starship init fish | source
    # Homebrew
    if test -d (brew --prefix)"/share/fish/completions"
        set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
    end
    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
end
