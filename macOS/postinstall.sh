sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName "$COMPUTER_NAME"

echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

sudo ln -s ~/Repositories/dotfiles/macOS/com.local.KeyRemapping.plist ~/Library/LaunchAgents/com.local.KeyRemapping.plist
sudo chown root:wheel ~/Library/LaunchAgents/com.local.KeyRemapping.plist
sudo ln -s ~/Repositories/dotfiles/macOS/config.fish ~/.config/fish/config.fish
