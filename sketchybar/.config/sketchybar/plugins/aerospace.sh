#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME label.color=0xffb4befe
else
    sketchybar --set $NAME label.color=0xffc9c7cd
fi
