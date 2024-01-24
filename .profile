# I haven't used .profile since I was an intern but one of these days I'm going to take a look at the remaining code and see if it's useful enough to move to my current dotfiles

# Bash
alias cls='echo -ne \"\033c\"' # Fix `clear` in macOS Hyper, probably other platforms https://www.reddit.com/r/bashonubuntuonwindows/comments/8szhn0/how_to_clear_terminal_screen_for_real/e1kr97w
alias down='DOWN=`fc -ln -1`;DOWN=${DOWN##* };if [ -d "$DOWN" ];then cd "$DOWN";else cd `ls -td {.[^.],}?*/ 2>/dev/null|head -1`;fi'
alias ll='gls --almost-all --classify --color --group-directories-first --human-readable -l --no-group --si'
eval "$(thefuck --alias please)"
alias pls='please'
alias uo='up'
alias up='cd ..'

# Python
export PYTHONSTARTUP=~/.pythonrc
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
