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

fish_add_path /usr/local/opt/curl/bin

# curl
set -gx CPPFLAGS -I/usr/local/opt/curl/include
set -gx LDFLAGS -L/usr/local/opt/curl/lib
set -gx PKG_CONFIG_PATH /usr/local/opt/curl/lib/pkgconfig

alias finished='afplay /System/Library/Sounds/Morse.aiff'
alias dock-spacer="defaults write com.apple.dock persistent-apps -array-add '{\"tile-type\"=\"spacer-tile\";}'killall Dock"
