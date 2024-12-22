#!/usr/bin/env bash

# Get the current Wi-Fi SSID
wifi_name=$(networksetup -listpreferredwirelessnetworks en0 | sed -n '2 p' | tr -d '\t')

COLOR="0xff94e2d5"
# If the Wi-Fi name is empty, set a default value (e.g., "No Wi-Fi")
if [ -z "$wifi_name" ]; then
    wifi_name="Offline"
    COLOR="0xfff38ba8"
fi

# Set the Wi-Fi name as the label in SketchyBar
sketchybar --set "$NAME" label="$wifi_name" icon.color="$COLOR"
