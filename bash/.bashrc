# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(fzf --bash)"
eval "$(zoxide init bash)"

export HISTFILE=~/.cmd_history
