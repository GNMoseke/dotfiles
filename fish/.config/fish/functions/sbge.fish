function sbge
    swift build $argv | rg "error:" -C 5
end
