set -gx REPOSITORIES $HOME/Repositories
source $REPOSITORIES/dotfiles/config.fish

if status is-interactive
    # Homebrew
    if test -d (brew --prefix)"/share/fish/completions"
        set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
    end
    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end

    # iTerm 2
    test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
end

# curl
fish_add_path /usr/local/opt/curl/bin
set -gx CPPFLAGS -I/usr/local/opt/curl/include
set -gx LDFLAGS -L/usr/local/opt/curl/lib
set -gx PKG_CONFIG_PATH /usr/local/opt/curl/lib/pkgconfig

alias dock-spacer="defaults write com.apple.dock persistent-apps -array-add '{\"tile-type\"=\"spacer-tile\";}'killall Dock"
alias finished='afplay /System/Library/Sounds/Morse.aiff'
