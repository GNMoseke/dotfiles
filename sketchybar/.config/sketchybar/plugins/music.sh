#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "media_change" ]; then
    STATE="$(echo "$INFO" | jq -r '.state')"
    if [ "$STATE" = "playing" ] || [ "$STATE" = "paused" ]; then
        SONG_INFO="$(echo "$INFO" | jq -r '.title + " - " + .artist')"
        sketchybar --set "$NAME" icon= scroll_texts=on label.max_chars=20 label="$SONG_INFO"
    else
        sketchybar --set "$NAME" drawing=off
    fi
fi
