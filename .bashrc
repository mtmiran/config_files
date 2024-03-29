# ____    _    ____  _   _ ____   ____
#| __ )  / \  / ___|| | | |  _ \ / ___|
#|  _ \ / _ \ \___ \| |_| | |_) | |
#| |_) / ___ \ ___) |  _  |  _ <| |___
#|____/_/   \_\____/|_| |_|_| \_\\____|

### SOURCES ###
PATH="$HOME/.local/bin${PATH:+:${PATH}}"

### GIT ###
parse_git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

### PS1 ###
function prompt {
	local NO_COLOR="\e[0m"
	local BLACK="\[\033[0;30m\]"
	local RED="\[\033[0;31m\]"
	local LIGHT_RED="\[\033[1;31m\]"
	local GREEN="\[\033[0;32m\]"
	local LIGHT_GREEN="\[\033[1;32m\]"
	local YELLOW="\[\033[0;33m\]"
	local LIGHT_YELLOW="\[\033[01;33m\]"
	local BLUE="\[\033[0;34m\]"
	local MAGENTA="\[\033[0;35m\]"
	local CYAN="\[\033[0;36m\]"
	local LIGHT_CYAN="\[\033[01;36m\]"
	local WHITE="\[\033[1;37m\]"
	local LIGHT_GRAY="\[\033[0;37m\]"

	PS1="${LIGHT_CYAN}\u@\h:${LIGHT_YELLOW}\W ${RED}\$(parse_git_branch) ${NO_COLOR}\n\$ "
}
prompt

### EXPORT ANT VARIABLES ###

export EDITOR="nvim"
export BROWSER="firefox"
export TERMINAL="xterm"
export MANPAGER="less"
export PAGER="less"
export TERM="xterm-256color"

### OPTIONS ###
#set -o vi

### ALIASES ###
alias ls='ls -l --color --group-directories-first'
alias cp="cp -i"
alias mv='mv -i'
alias top='bashtop'
alias vi='nvim'
# alias find='fd --hidden'
alias fd='fd --hidden'
alias tmux="TERM=xterm-256color tmux"

## teclado abnt2
if [[ -f $HOME/.Xmodmap ]]; then
	xmodmap "$HOME/.Xmodmap"
fi
