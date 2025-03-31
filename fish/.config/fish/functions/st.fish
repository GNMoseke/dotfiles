function st
    swift test -Xswiftc -Xfrontend -Xswiftc -disable-round-trip-debug-types $argv
end
