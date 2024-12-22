#!/usr/bin/env bash

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
    [6-9][0-9]|100) ICON="" COLOR="0xff94e2d5"
    ;;
    [3-5][0-9]) ICON="" COLOR="0xff94e2d5"
    ;;
    [1-9]|[1-2][0-9]) ICON="" COLOR="0xff94e2d5"
    ;;
    *) ICON="󰖁" COLOR="0xfff38ba8"
  esac

  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%" icon.color="$COLOR"
fi
