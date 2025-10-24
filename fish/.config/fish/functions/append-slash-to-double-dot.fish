# https://news.ycombinator.com/item?id=45682492
function append-slash-to-double-dot -d 'expand .. to ../'
    # Get commandline up to cursor
    set -l cmd (commandline --cut-at-cursor)

    # Match last line
    switch $cmd[-1]
    case '*.'
        commandline --insert './'
    case '*'
        commandline --insert '.'
    end
end
