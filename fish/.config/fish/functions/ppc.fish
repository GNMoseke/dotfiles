function ppc
    docker container ls -a --format 'table {{.ID}}\t{{ printf "%.25s" .Names }}\t{{ .State}}\t{{ .Ports }}' | awk 'NR<2{print $0;next}{print $0| "sort -r -k3"}'
end
