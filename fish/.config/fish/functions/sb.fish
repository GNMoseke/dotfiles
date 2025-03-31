function sb
    swift build -Xswiftc -Xfrontend -Xswiftc -disable-round-trip-debug-types $argv
end
