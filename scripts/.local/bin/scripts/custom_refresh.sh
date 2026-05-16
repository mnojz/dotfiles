#!/usr/bin/env bash

MONITOR="eDP-1"

# Extract current refresh rate (integer part only)
RATE=$(hyprctl monitors | awk -v mon="$MONITOR" '
    $0 ~ "Monitor " mon {
        getline
        if (match($0, /@([0-9]+)/, arr)) {
            print arr[1]
        }
    }
')

# Decide next rate
if [ "$RATE" -ge 100 ]; then
    NEW_RATE=60
else
    NEW_RATE=144
fi

# Apply
hyprctl keyword "monitor $MONITOR,1920x1080@${NEW_RATE},0x0,1"

# Notify
notify-send "Refresh rate: ${NEW_RATE}Hz"