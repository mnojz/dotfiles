#!/usr/bin/env bash

TOUCHPAD="elan0307:00-04f3:3282-touchpad"
STATE_FILE="$HOME/.cache/touchpad_state"

# Create state file if missing
[ -f "$STATE_FILE" ] || echo "1" > "$STATE_FILE"

STATE=$(cat "$STATE_FILE")

if [ "$STATE" = "1" ]; then
    hyprctl eval "keyword device[$TOUCHPAD]:enabled 0"
    echo "0" > "$STATE_FILE"
    notify-send "Touchpad disabled"
else
    hyprctl eval "keyword device[$TOUCHPAD]:enabled 1"
    echo "1" > "$STATE_FILE"
    notify-send "Touchpad enabled"
fi