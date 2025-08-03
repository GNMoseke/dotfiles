# TODO: can remove this when ath supports it as part of the tui
function flashcards
    set -l set (cd ~/.athenaeum && lsd --human-readable . | fzf | sed -e 's/\..*$//')
    set -l side (echo -e "front\nreverse" | fzf --preview 'echo {}')
    if [ "$side" = "reverse" ]
        ath --sets-dir ~/.athenaeum/ --set "$set" --shuffle --capitalize --reverse
    else
        ath --sets-dir ~/.athenaeum/ --set "$set" --shuffle --capitalize
    end
end

