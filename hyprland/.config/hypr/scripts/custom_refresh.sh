#!/usr/bin/env bash

MONITOR="eDP-1"

RATE=$(hyprctl monitors | \
grep -A1 "Monitor $MONITOR" | \
tail -n1 | \
sed -E 's/.*@([0-9]+)\..*/\1/')

# Decide next rate
if [ "$RATE" -ge 100 ]; then
    NEW_RATE=60
else
    NEW_RATE=144
fi

# Apply
hyprctl eval "hl.monitor({
    output = \"$MONITOR\",
    mode = \"1920x1080@${NEW_RATE}\",
    position = \"0x0\",
    scale = 1
})"

# Notify
notify-send "Refresh rate: ${NEW_RATE}Hz"