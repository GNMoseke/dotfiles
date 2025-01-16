# Is there a better way to do this? I'm sure
# Do I care for something this simple? No.

function dev
    cd $argv
    if not set -q TMUX
        tmux new-session -d
        tmux split-window -h -l "66%" 'vim .'
        tmux -2 attach-session -d
    else
        tmux split-window -h -l "66%" 'vim .'
    end
end
