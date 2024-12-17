function ffetch
    set -l conf (random choice 2 7 10 18)
    fastfetch -c examples/$conf
end
