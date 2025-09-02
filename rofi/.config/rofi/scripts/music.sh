#!/usr/bin/env bash

PATH=$PATH:"$HOME/.local/bin/"
if [[ $# -eq 0 ]] ; then
    eurydice collection --format rofi
    exit 0
fi

path=$(eurydice collection --format json | jq --arg sel "$1" -r '.[$sel] | .path,.item_type,.cover_path')
readarray -t params <<< "$path"

case "${params[1]}" in
    Track | Album)
        mpc add "${params[0]}";;
    # in this case, the path stores the command to execute, so do so. Is this dangerous?
    # ...Perhaps.
    Playlist)
        eval "${params[0]}";;
    *)
        echo "Unknown options in ${params[@]}";;
esac

mpc play
if [ "${params[2]}" = "null" ]; then
    notify-send --transient -a Music "ADDED TO QUEUE" "$1"
else
    notify-send --transient -a Music -i "${params[2]}" "ADDED TO QUEUE" "$1"
fi
