function sbge
    swift build -Xswiftc -Xfrontend -Xswiftc -disable-round-trip-debug-types $argv | rg "error:" -C 5
end
