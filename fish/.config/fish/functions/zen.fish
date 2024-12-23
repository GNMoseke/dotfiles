function zen
    if not set -q TMUX
        echo "not in tmux"
    end
    tmux split-window -h "nvim $argv"
    tmux split-window -h "pipes.sh -p 4 -t 1 -s 15 -R -f 15 -r 5000"
    tmux select-layout even-horizontal
    tmux send-keys -t left 'cbonsai -l -t 3 -L 80' C-m
    tmux select-pane -t 1
end
