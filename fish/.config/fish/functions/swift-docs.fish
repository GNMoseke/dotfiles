function swift-docs
    if [ $(swift package describe --type json | jq -c '.dependencies[] | select(.identity == "swift-docc-plugin")') ]
        swift package --disable-sandbox preview-documentation --product $argv
    else
        echo "No swift-docc-plugin dependency found or not a swift package"
    end
end
