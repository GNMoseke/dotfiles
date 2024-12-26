#!/usr/bin/env bash

# credit to https://github.com/hyprwm/hyprpaper/issues/194#issuecomment-2324632187
 
# Pick random wallpaper
random_pick=$(find "/home/garrett/Pictures/Wallpaper/" -type f -name "*.png" -o -name "*.jpg" | shuf -n1)
# Replace the placeholder in template and save to .conf file
sed -e "s~<wp>~${random_pick}~g" ~/.config/hypr/templates/hyprpaper.template > ~/.config/hypr/hyprpaper.conf
