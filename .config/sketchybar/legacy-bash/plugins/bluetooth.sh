#!/bin/bash

BT_ON=󰂯
BT_CONNECTED=󰂱
BT_OFF=󰂲

source "$HOME/.config/sketchybar/colors.sh"

if ! command -v blueutil >/dev/null; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

if [ "$(blueutil --power)" != "1" ]; then
  sketchybar --set "$NAME" icon=$BT_OFF icon.color=$GREY label="" label.drawing=off
  exit 0
fi

# First connected device name, plus a count when there are more
DEVICES=$(blueutil --connected --format json | jq -r '.[].name')
COUNT=$(grep -c . <<< "$DEVICES")

if [ "$COUNT" -eq 0 ]; then
  sketchybar --set "$NAME" icon=$BT_ON icon.color=$WHITE label="" label.drawing=off
else
  LABEL=$(head -n1 <<< "$DEVICES")
  [ "$COUNT" -gt 1 ] && LABEL="$LABEL +$((COUNT - 1))"
  sketchybar --set "$NAME" icon=$BT_CONNECTED icon.color=$BLUE label="$LABEL" label.drawing=on
fi
