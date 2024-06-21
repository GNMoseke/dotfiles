set -g fish_greeting $(fortune)

if status is-interactive
and not set -q TMUX
    exec tmux
end

# starship
starship init fish | source

set --global --export MANPAGER batcat
set --global --export EDITOR nvim

# ===== Convenience Aliases =====
# ensure lsd is installed: https://github.com/lsd-rs/lsd
alias ls="lsd -l"
alias code="codium"
alias crabrave="open 'https://youtu.be/LDU_Txk06tM?t=28'"
alias vim="nvim"
alias docker="podman"
alias cat="batcat"
alias loc="tokei"
