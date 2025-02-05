function swift-bench
    if [ $(swift package describe --type json | jq -c '.dependencies[] | select(.identity == "package-benchmark")') ]
        swift package --disable-sandbox benchmark $argv
    else
        echo "No package-benchmark dependency found or not a swift package"
    end
end
