function swift-nuke
    argparse h/help s/scorchedearth -- $argv
    or return

    if ! test -e Package.swift
        echo "Not in a swift package"
        return
    end

    # If -h or --help is given, we print a little help text and return
    if set -ql _flag_help
        echo "swift-nuke [-h|--help] [-s|--scorchedearth]"
        echo "--scorchedearth additionally nukes:"
        echo "    ~/Library/Caches/org.swift.swiftpm"
        echo "    ~/Library/org.swift.swiftpm"
        echo "    ~/Library/Caches/sourcekit-lsp"
        echo "    ~/Library/Caches/swift-build"
        echo "    ~/Library/Caches/swift-run"
        echo "    ~/Library/Caches/swift-test"
        echo "    ~/Library/Developer/Xcode/DerivedData"
        return 0
    end

    if set -ql _flag_scorchedearth
        if read_confirm
            rm -rf .build/
            swift package clean
            rm -rf ~/Library/Caches/org.swift.swiftpm \
                    ~/Library/org.swift.swiftpm \
                    ~/Library/Caches/sourcekit-lsp \
                    ~/Library/Caches/swift-build \
                    ~/Library/Caches/swift-run \
                    ~/Library/Caches/swift-test \
                    ~/Library/Developer/Xcode/DerivedData
            echo "💣💣💣 Successful"
        end
    else
        rm -rf .build/
        swift package clean
        echo "💣 Successful"
    end
end

function read_confirm
  while true
    read -l -P 'This will blast ALL system-wide swift cache. Do you want to continue? [y/N] ' confirm

    switch $confirm
      case Y y
        return 0
      case '' N n
        echo "Cancelled"
        return 1
    end
  end
end
