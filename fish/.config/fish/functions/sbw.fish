function sbw
    swift build -Xswiftc -Xfrontend -Xswiftc -disable-round-trip-debug-types -Xswiftc -warnings-as-errors -Xcc -Werror $argv
end
