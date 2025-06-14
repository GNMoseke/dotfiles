#!/bin/bash

while true; do
    curr_temp=$(cat /sys/class/hwmon/hwmon3/temp1_input)
    if (( $curr_temp > 96000 )); then
        notify-send "CPU Temp Above 96°" \
            --urgency normal \
            --app-name "hwmon" \
            --icon "$(realpath ~/Pictures/Misc/temperature-alert.jpg)" \
            --expire-time 3000 \
            --transient
    fi
    sleep 10
done
