# Is there a better way to do this? I'm sure
# Do I care for something this simple? No.

function dev
    cd $argv
    if not set -q TMUX
        tmux new-session -d 'vim .'
        tmux split-window -h
        tmux split-window -v 'lazygit'
        tmux select-pane -t left
        tmux -2 attach-session -d
    else
        tmux split-window -h
        tmux split-window -v 'lazygit'
        tmux select-pane -t left
        vim .
    end
end
