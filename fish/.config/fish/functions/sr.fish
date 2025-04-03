function sr
    swift run -Xswiftc -Xfrontend -Xswiftc -disable-round-trip-debug-types $argv
end
