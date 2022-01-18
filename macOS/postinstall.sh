REPOSITORIES=$HOME/Repositories

sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName "$COMPUTER_NAME"

echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

sudo ln -s $REPOSITORIES/dotfiles/macOS/com.local.KeyRemapping.plist ~/Library/LaunchAgents/com.local.KeyRemapping.plist
sudo chown root:wheel ~/Library/LaunchAgents/com.local.KeyRemapping.plist
ln -sf $REPOSITORIES/dotfiles/macOS/config.fish ~/.config/fish/config.fish
ln -sf $REPOSITORIES/dotfiles/starship.toml ~/.config/starship.toml

git clone https://github.com/androguard/androguard.git $REPOSITORIES/androguard
pushd $REPOSITORIES/androguard
git checkout cd0f6a60a639cdecc4df40948fb0a172657f8b3b # version with androsim
popd

git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git $REPOSITORIES/Mobile-Security-Framework-MobSF
pushd $REPOSITORIES/Mobile-Security-Framework-MobSF
bash setup.sh
popd
