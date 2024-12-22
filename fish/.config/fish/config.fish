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
alias fzf='fzf --preview "bat --color=always {}"'

# OS-specific config
switch (uname)
    case Linux
        alias code="codium"
        alias docker="podman"
    case Darwin
        if which swiftenv > /dev/null; status --is-interactive; and source (swiftenv init -|psub); end
    case '*'
        echo Unconfigured OS
end

