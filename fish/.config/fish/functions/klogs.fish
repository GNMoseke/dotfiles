function klogs
    [ $(which tspin) ] || { echo "install tailspin"; exit 1 }
    kubectl logs $argv | tspin
end
