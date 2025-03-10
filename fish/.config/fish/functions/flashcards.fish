# TODO: can remove this when ath supports it as part of the tui
function flashcards
    set -l set (cd ~/.athenaeum && lsd --human-readable . | fzf --tmux 80% | sed -e 's/\..*$//')
    ath --sets-dir ~/.athenaeum/ --set "$set" --shuffle --capitalize
end

