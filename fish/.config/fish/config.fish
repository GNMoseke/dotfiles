set -g fish_greeting $(fortune)

if status is-interactive
and not set -q TMUX
    exec tmux
end

# starship
starship init fish | source

set --global --export EDITOR nvim

# ===== Convenience Aliases =====
# ensure lsd is installed: https://github.com/lsd-rs/lsd
alias ls="lsd -l"
alias crabrave="open 'https://youtu.be/LDU_Txk06tM?t=28'"
alias vim="nvim"
alias loc="tokei"

# OS-specific config
switch (uname)
    case Linux
        # bat binary is batcat on debian systems
        set --global --export MANPAGER batcat
        alias cat="batcat"
        alias code="codium"
        alias docker="podman"
    case Darwin
        alias cat="bat"
    case '*'
        echo Unconfigured OS
end
