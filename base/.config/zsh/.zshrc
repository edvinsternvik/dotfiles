# History
HISTFILE=~/.cache/zshhistory
HISTSIZE=10000
SAVEHIST=10000

# Options
setopt autocd
unsetopt beep
PROMPT_EOL_MARK=""

# Aliases
alias ls="ls --color=auto"

# Vim mode
bindkey -v
export KEYTIMEOUT=1

# zmodload zsh/complist
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history

cursor_mode() {
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

# Allow backspace in insert mode
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# Edit current command in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# fzf integration
source <(fzf --zsh)

# Completion
zstyle :compinstall filename '/home/edvin/.config/zsh/.zshrc'
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

# Prompt
PROMPT='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

# GHC
[ -f "/home/edvin/.ghcup/env" ] && . "/home/edvin/.ghcup/env" # ghcup-env
