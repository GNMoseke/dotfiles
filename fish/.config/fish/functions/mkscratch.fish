# converted to fish and simplified from https://codeberg.org/EvanHahn/dotfiles/src/commit/843b9ee13d949d346a4a73ccee2a99351aed285b/home/zsh/.config/zsh/aliases.zsh#L43-L51
function mkscratch
    cd "$(mktemp -d)"
    chmod -R 0700 .
end
