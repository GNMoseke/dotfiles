# tweaked from https://codeberg.org/EvanHahn/dotfiles/src/commit/843b9ee13d949d346a4a73ccee2a99351aed285b/home/bin/bin/mksh#
function mkbash
    if test (count $argv) -ne 1
        echo 'mkbash takes one argument' 1>&2
    else if test -e "$argv[1]"
        echo "$argv[1] already exists" 1>&2
    else
        # Intentionally non-escaped variable expansion because it's getting shoved into a
        # bash file
        # @fish-lsp-disable-next-line 2001
        echo '#!/usr/bin/env bash
set -euo pipefail

show_help() {
    cat <<HELPMSG
    Summary
    Usage: $0
    Options:
        * -h | --help: show this message and exit.
HELPMSG
    exit 0
}

while true; do
  case "$1" in
    -h | --help ) show_help;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done
' >"$argv[1]"

        chmod u+x "$argv[1]"
        "$EDITOR" "$argv[1]"
    end

end
