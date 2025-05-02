# Requires:
# https://github.com/race604/clock-tui
# https://github.com/newsboat/newsboat
function today
    tmux split-window -h "flashcards"
    tclock -c Magenta timer -d 10m
    newsboat
end
