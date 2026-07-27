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
	local RED="\[\033[0;31m\]"
	local USER_COLOR="\[\e[38;5;62;1;1m\]"
	local HOSTNAME_COLOR="\[\e[38;5;102;1m\]"
	local DIRECTORY_COLOR="\[\e[38;5;138;1;3m\]"

	PS1="${USER_COLOR}\u${NO_COLOR}@${HOSTNAME_COLOR}\h:${DIRECTORY_COLOR}\W ${RED}\$(parse_git_branch) ${NO_COLOR}\n\$ "
}
prompt


### EXPORT ANT VARIABLES ###
export EDITOR="nvim"
export BROWSER="firefox-esr"
export TERMINAL="xterm"
export MANPAGER="less"
export PAGER="less"
export TERM="xterm-256color"
export PATH="/usr/bin:$PATH"
export vblank_mode=0


### ALIASES ###
alias vi="nvim"
alias ls='ls -l --color --group-directories-first'
alias cp="cp -i"
alias mv='mv -i'
# alias find='fd --hidden'
alias fd='fd --hidden'
alias arquivos='cd /mnt/Arquivos'
alias tmux="TERM=xterm-256color tmux"
# alias nvfzf="vim $(fzf --preview='cat {}')"
alias du="du -sh */"

# deactivate conda env by default
export CONDA_AUTO_ACTIVATE_BASE=false
