# tweaked from https://codeberg.org/EvanHahn/dotfiles/src/commit/843b9ee13d949d346a4a73ccee2a99351aed285b/home/bin/bin/mksh#
function mkbash
    if test (count $argv) -ne 1
        echo 'mkbash takes one argument' 1>&2
    else if test -e "$argv[1]"
        echo "$argv[1] already exists" 1>&2
    else
        echo '#!/usr/bin/env bash
set -euo pipefail
' >"$argv[1]"

        chmod u+x "$argv[1]"
        "$EDITOR" "$argv[1]"
    end

end
