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
alias cls='echo -ne \"\033c\"' # Fix `clear` in macOS Hyper, probably other platforms https://www.reddit.com/r/bashonubuntuonwindows/comments/8szhn0/how_to_clear_terminal_screen_for_real/e1kr97w
alias down='DOWN=`fc -ln -1`;DOWN=${DOWN##* };if [ -d "$DOWN" ];then cd "$DOWN";else cd `ls -td {.[^.],}?*/ 2>/dev/null|head -1`;fi'
alias exity='exit'
alias ll='gls --almost-all --classify --color --group-directories-first --human-readable -l --no-group --si'
eval "$(thefuck --alias please)"
alias pls='please'
alias profile='$EDITOR ~/.profile'
alias relaod='reload'
alias reload='source ~/.profile;clear'
alias uo='up'
alias up='cd ..'

# git
alias add='git add'
alias branch='git checkout -b'
alias checkout='git checkout'
function clone {
    git clone git@github.com:$1/$2 "${@:3}"
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
alias thunk='osascript -e beep'

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

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Tailwind
source $HOME/.tw/tw-bash-completion.sh

if [ $(pwd) = ~ ]; then cd ~/Desktop; fi
