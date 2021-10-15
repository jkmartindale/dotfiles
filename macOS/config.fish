if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x LC_ALL en_US.UTF-8
    starship init fish | source
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
