function bench-swift
    if [ $(swift package describe --type json | jq -c '.dependencies[] | select(.identity == "package-benchmark")') ]
        swift package --disable-sandbox benchmark
    else
        echo "No package-benchmark dependency found or not a swift package"
    end
end
