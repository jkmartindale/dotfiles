set -x BROWSER wslview
set -x EDITOR code
set -x SHELL fish
set -gx REPOSITORIES $HOME/Repositories
source $REPOSITORIES/dotfiles/config.fish

if status is-interactive
    # Homebrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    if test -d (brew --prefix)"/share/fish/completions"
        set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
    end
    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end

    starship init fish | source
end

