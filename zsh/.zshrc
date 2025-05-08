[ "$TERM" = linux ] && export TERM=xterm-256color

if [ -z "$TMUX" ]; then
    if [ $(pgrep -c tmux) -gt 1 ]; then
        tmux new
    else
        tmux attach 2> /dev/null || tmux new
    fi
fi
stty -ixon
bindkey -er '^s'

alias cal='cal --monday'
alias pss='pgrep -ia' #-alf
alias du='du -sh'
alias y='yazi'
alias t='tmux'
alias vi='nvim'
alias v='vi'
alias top='btop'
alias cat='bat --style=grid'
alias ca='/usr/bin/cat'
alias xclip='xclip -selection clipboard'
alias mk='makepkg -sic'
alias rc='nvim ~/.zshrc'
alias so='source ~/.zshrc'

alias tree="tree -C"
programs=("grep" "rg" "pacman" "auracle" "ls" "diff")
for program in "${programs[@]}"; do
    alias $program="$program --color=always"
done

export PATH=~/.bin:$PATH:~/.cargo/bin
export EDITOR=/usr/bin/nvim
export LESS=iR
export SYSTEMD_LESS=-iFRSXMK
export MANPAGER='nvim +Man!'
export AUR_PAGER='yazi'

export LDLIBS="-lcrypt -lcs50 -lm"
export LD_LIBRARY_PATH=/usr/local/lib
export LIBRARY_PATH=/usr/local/lib
export C_INCLUDE_PATH=/usr/local/include
export PYTHON_HISTORY="$HOME/.local/state/python_history"

export HISTSIZE=10000 SAVEHIST=10000
export HISTFILE=~/.cmd_history
setopt hist_ignore_all_dups hist_ignore_space
setopt share_history
setopt inc_append_history # write to the history file immediately, not when the shell exits
setopt autocd

autoload -Uz compinit && compinit -d "$HOME/.cache/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' # case-insensitive
eval $(dircolors)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# _comp_options+=(globdots) # Include hidden files.

zmodload zsh/complist # shift-tab:
bindkey -M menuselect '^[[Z' reverse-menu-complete

bindkey -e '^[[3~' delete-char # fix DEL
bindkey '^p' history-beginning-search-backward # smart history 
bindkey '^n' history-beginning-search-forward # smart history 
WORDCHARS=${WORDCHARS/\/} # smart ^w

eval "$(zoxide init --cmd cd zsh)"
source <(fzf --zsh)

source $HOME/.config/zsh-fzf-tab/fzf-tab.plugin.zsh # shift-tab
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^[v" edit-command-line # edit command in vim

# prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
setopt prompt_subst
CYAN='%F{cyan}'
BOLD='%B'
RESET='%f%b'
PS1='${BOLD}${CYAN}%~${RESET} ${vcs_info_msg_0_}
${BOLD}>${RESET} '
