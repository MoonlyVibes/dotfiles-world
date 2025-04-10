if status is-interactive
# Commands to run in interactive sessions can go here

if test "$TERM" = "linux"
    set -x TERM xterm-256color
end

if not set -q TMUX
    if test (count (pgrep tmux)) -gt 1
        tmux new
    else
        tmux attach 2> /dev/null || tmux new
    end
end

alias tree "tree -C"
alias cal "cal --monday"
alias pss "pgrep -ia"
alias du "du -sh"
alias y "yazi"
alias t "tmux"
alias vi "nvim"
alias v "vi"
alias lsa "ls -a"
alias g "grep -i"
alias top "btop"
alias cat "bat --style=grid"
alias ca "/usr/bin/cat"
alias xclip "xclip -selection clipboard"
alias mk "makepkg -sic"
alias rc "nvim ~/.config/fish/config.fish"
alias so "source ~/.config/fish/config.fish"

for prog in grep rg pacman auracle ls diff
    alias $prog "$prog --color=always"
end

zoxide init --cmd cd fish | source

set -x PATH $HOME/.bin $HOME/.cargo/bin $PATH
set -x EDITOR /usr/bin/nvim
set -x LESS iR
set -x SYSTEMD_LESS -iFRSXMK
set -x MANPAGER 'nvim +Man!'
set -x AUR_PAGER 'yazi'

set -x LDLIBS "-lcrypt -lcs50 -lm"
set -x LD_LIBRARY_PATH /usr/local/lib
set -x LIBRARY_PATH /usr/local/lib
set -x C_INCLUDE_PATH /usr/local/include
set -x PYTHON_HISTORY "$HOME/.local/state/python_history"

end
