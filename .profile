# MacPorts Installer addition on 2018-05-15_at_10:00:32: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Prompt customization
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
export PS1='\[\e[36m\]\u // \W$(__git_ps1) $ \[\e[m\]'
export PS2='\[\e[36m\]... \[\e[m\]'
export PS4='\[\e[36m\]+++ \[\e[m\]'

# Bad typing helperd
alias exity='exit'
alias gti='git'
eval "$(thefuck --alias please)"
alias pls='please'
alias relaod='reload'
alias uo='up'

# Lazy typing helpers
alias add='git add'
alias branch='git checkout -b'
alias build='bin/pip install .'
alias checkout='git checkout'
alias commit='git commit -m'
alias down='DOWN=`fc -ln -1`;DOWN=${DOWN##* };if [ -d "$DOWN" ];then cd "$DOWN";else cd `ls -td {.[^.],}?*/ 2>/dev/null|head -1`;fi'
alias finder='open'
alias forgit='git checkout --'
alias merge='git merge'
alias profile='code ~/Projects/dotfiles/.profile'
alias push='git push origin'
alias py='bin/python'
alias pyrc='code ~/.pythonrc'
alias rebuild='bin/pip install . --force-reinstall'
alias reload='source ~/.profile;clear'
alias status='git status'
alias up='cd ..'
alias venv='python3 -m venv .;bin/pip install --upgrade pip'

# Actual improvements
alias ll='ls -AFGlh'
export PYTHONSTARTUP=~/.pythonrc

# I rarely do anything outside of this folder so
cd ~/Projects
