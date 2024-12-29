#!/usr/bin/env bash
random_background=$(find "$HOME/Pictures/Wallpaper/" -type f -name "*.png" -o -name "*.jpg" | shuf -n 1)

hyprctl -q hyprpaper unload all
hyprctl -q hyprpaper preload $random_background
hyprctl -q hyprpaper wallpaper "DP-3, $random_background"

