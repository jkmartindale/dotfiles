export EDITOR='code --wait'

# Prompt customization
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE='ye'
export GIT_PS1_SHOWSTASHSTATE='pls'
export GIT_PS1_SHOWUPSTREAM='ya'
export PS1='\[\e[34m\]\u // \W$(__git_ps1) $ \[\e[m\]'
export PS2='\[\e[34m\]... \[\e[m\]'
export PS4='\[\e[34m\]+++ \[\e[m\]'

# Bash
alias down='DOWN=`fc -ln -1`;DOWN=${DOWN##* };if [ -d "$DOWN" ];then cd "$DOWN";else cd `ls -td {.[^.],}?*/ 2>/dev/null|head -1`;fi'
alias exity='exit'
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
function clone {
    git clone git@github.com:$1/$2
}
alias commit='git commit -m'
alias forgit='git checkout --'
alias gti='git'
alias merge='git merge'
alias pull='git pull'
alias push='git push origin'
alias revert='git revert'
alias status='git status'

# macOS
alias dnsflush='sudo killall -HUP mDNSResponder'
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Python
alias build='bin/pip install -e .'
alias pipstall='bin/pip install'
alias py='bin/python'
alias pyrc='code ~/.pythonrc'
alias venv='rm -r lib; python3 -m venv .;bin/pip install --upgrade pip'
export PYTHONSTARTUP=~/.pythonrc
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip

# NTI
alias dataserver='~/Projects/nti.dataserver-buildout/bin/supervisord -n'
alias webserver='cd ~/Projects/nti.web.app;npm start'
export CPPFLAGS=-I/opt/local/include
export LDFLAGS=-L/opt/local/lib
export PATH="/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH"
export VIRTUAL_ENV=/opt/local
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
if [ $(pwd) = ~ ]; then cd ~/Projects; fi
