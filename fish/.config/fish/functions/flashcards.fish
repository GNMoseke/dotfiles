# TODO: can remove this when ath supports it as part of the tui
function flashcards
    set -l set (lsd --human-readable ~/.athenaeum/ | fzf | sed -e 's/\..*$//')
    ath --sets-dir ~/.athenaeum/ --set "$set" --shuffle --capitalize
end

