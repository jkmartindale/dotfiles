# Variables
set -x BROWSER wslview

# Aliases/functions
function wsl-interop -d "Re-enable WSL interop when systemd nukes it"
    # https://github.com/microsoft/WSL/issues/8952#issuecomment-1568212651
    sudo sh -c 'echo :WSLInterop:M::MZ::/init:PF > /usr/lib/binfmt.d/WSLInterop.conf'
    sudo systemctl restart systemd-binfmt
end

# Homebrew
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fish_add_path ~/.local/bin

# Unified config
set -gx REPOSITORIES $USERPROFILE/Repositories
source $REPOSITORIES/dotfiles/config.fish
