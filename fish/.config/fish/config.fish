set -g fish_greeting $(fortune)

if status is-interactive
and not set -q TMUX
    exec tmux new-session -A -s main
end

# starship
starship init fish | source

set --global --export EDITOR nvim
set --global --export MANPAGER bat

# ===== Convenience Aliases =====
# ensure lsd is installed: https://github.com/lsd-rs/lsd
alias ls="lsd -l"
alias lss="lsd -l --sizesort --total-size"
alias crabrave="open 'https://youtu.be/LDU_Txk06tM?t=28'"
alias vim="nvim"
alias loc="tokei"
alias cat="bat"
alias fzf='fzf --preview "bat --color=always {}" --style full'
alias jj-watch='viddy "jj log --ignore-working-copy --color always"'
alias rm='rm -I'

# fun
alias pipes="pipes.sh -p 5 -t 1 -s 15 -R -f 60 -r 6000"

# thanks https://github.com/fish-shell/fish-shell/issues/1891#issuecomment-452141339
bind . 'append-slash-to-double-dot'

# OS-specific config
switch (uname)
    case Linux
        # see: https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_(orphans)
        alias pacprune="sudo pacman -Qdtq | sudo pacman -Rns -"
    case Darwin
        if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"; end
    case '*'
        echo Unconfigured OS
end
