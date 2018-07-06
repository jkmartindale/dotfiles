# MacPorts Installer addition on 2018-05-15_at_10:00:32: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Prompt customization
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
export PS1='\[\e[34m\]\u // \W$(__git_ps1) $ \[\e[m\]'
export PS2='\[\e[34m\]... \[\e[m\]'
export PS4='\[\e[34m\]+++ \[\e[m\]'

# cd to Projects if another working directory isn't already set
if [ $(pwd) = ~ ]; then cd ~/Projects; fi

# Bash
alias down='DOWN=`fc -ln -1`;DOWN=${DOWN##* };if [ -d "$DOWN" ];then cd "$DOWN";else cd `ls -td {.[^.],}?*/ 2>/dev/null|head -1`;fi'
alias exity='exit'
alias finder='open'
alias ll='ls -AFGlh'
eval "$(thefuck --alias please)"
alias pls='please'
alias profile='code ~/Projects/dotfiles/.profile'
alias relaod='reload'
alias reload='source ~/.profile;clear'
alias uo='up'
alias up='cd ..'

# git
alias add='git add'
alias branch='git checkout -b'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias forgit='git checkout --'
alias gti='git'
alias merge='git merge'
alias pull='git pull'
alias push='git push origin'
alias status='git status'

# Python
export PYTHONSTARTUP=~/.pythonrc
alias build='bin/pip install .'
alias py='bin/python'
alias pyrc='code ~/.pythonrc'
alias rebuild='bin/pip install . --force-reinstall'
alias venv='rm -r lib; python3 -m venv .;bin/pip install --upgrade pip'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
