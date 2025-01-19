function zen
    if not set -q TMUX
        echo "not in tmux"
    end
    tmux split-window -h "nvim $argv"
    tmux split-window -h
    tmux select-layout even-horizontal
    sleep 0.2
    tmux send-keys -t left 'cbonsai -l -t 3 -L 80' C-m
    tmux send-keys -t right 'cbonsai -l -t 3 -L 80' C-m
    tmux select-pane -t 1
end
