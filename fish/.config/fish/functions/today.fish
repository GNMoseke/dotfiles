# Requires:
# https://github.com/race604/clock-tui
# https://github.com/newsboat/newsboat
# https://github.com/ericchiang/pup
function today
    tmux split-window -h "flashcards"
    # TODO:
    # * add a "-e" to this command for tracking days that I actually did my flashcards?
    # * play a custom playlist with mpc? Or shuffle randomly?
    tclock -c Magenta timer -d 10m
    echo -e "\033[1;35m === HET (WILLEKEURIG) WORD VAN VANDAAG === \033[0m"
    set -l wvv (curl -s -L https://www.woordvanvandaag.nl/random | \
        pup 'p:nth-child(7) text{}' | \
        tr -d '\n' | tr -s '\t')
    set -l components (string split '=' -- $wvv)
    set -l nl (string trim -- $components[1])
    set -l en (string trim -- $components[2])
    echo -e "\033[0;32m$nl\033[0m"
    echo -e "\033[0;34m$en\033[0m"

    set -l csv '"'$nl'","'$en'"'
    set -l exists (rg -F "$csv" ~/dotfiles/flashcards/.athenaeum/word_van_vandaag.csv)
    if test -n "$exists" 
        echo "Already in flashcard set!"
    else
        echo "$csv" >> ~/dotfiles/flashcards/.athenaeum/word_van_vandaag.csv
        echo "Added to flashcard set!"
        cd ~/dotfiles && git add flashcards/.athenaeum/word_van_vandaag.csv && git commit -m "auto(flashcards): wvv"
        cd -
    end
    newsboat --quiet
    notes
end
