#!/usr/bin/env bash

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON="" COLOR="0xffa6e3a1"
  ;;
  [6-8][0-9]) ICON="" COLOR="0xff94e2d5"
  ;;
  [3-5][0-9]) ICON="" COLOR="0xfffab387"
  ;;
  [1-2][0-9]) ICON="" COLOR="0xfff38ba8"
  ;;
  *) ICON=""
esac

if [[ "$CHARGING" != "" ]]; then
  ICON="" COLOR="0xffa6e3a1"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" icon.color="$COLOR"
