#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim
export VISUAL=nvim
export PATH="$PATH:/$HOME/bin"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[0m\][\[\e[0;36m\]\w\[\e[0m\]] \[\e[0;1;31m\]-\[\e[0;1;31m\]> \[\e[0m\]$()\[\e[0m\]'
