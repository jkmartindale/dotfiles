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

# Android SDK
fish_add_path ~/Library/Android/sdk/build-tools/(ls ~/Library/Android/sdk/build-tools)[-1]

# binutils
fish_add_path /usr/local/opt/binutils/bin
set -gx LDFLAGS "-L/usr/local/opt/binutils/lib"
set -gx CPPFLAGS "-I/usr/local/opt/binutils/include"

# curl
fish_add_path /usr/local/opt/curl/bin
set -gx CPPFLAGS -I/usr/local/opt/curl/include
set -gx LDFLAGS -L/usr/local/opt/curl/lib
set -gx PKG_CONFIG_PATH /usr/local/opt/curl/lib/pkgconfig

# digcaa
fish_add_path $REPOSITORIES/dnscaa

alias androsim='python2 $REPOSITORIES/androguard/androsim.py'
alias brewlist='brew leaves | xargs brew deps --include-build --tree' # https://stackoverflow.com/a/61928483/3427178
alias dock-spacer="defaults write com.apple.dock persistent-apps -array-add '{\"tile-type\"=\"spacer-tile\";}'killall Dock"
alias finished='afplay /System/Library/Sounds/Morse.aiff'
alias pip=pip3
alias python=python3

function upgrade
    set_color -u; echo "Homebrew"; set_color normal
    brew upgrade
    set_color -u; echo -e "\nMac App Store"; set_color normal
    mas upgrade
    set_color -u; echo -e "\nnpm (Global)"; set_color normal
    npm -g upgrade
    set_color -u; echo -e "\ntldr"; set_color normal
    tldr --update
end
