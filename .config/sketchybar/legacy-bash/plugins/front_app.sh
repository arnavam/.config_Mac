#!/bin/bash

if [ "$SENDER" = "front_app_switched" ]; then
  ICON=$("$HOME/.config/sketchybar/plugins/icon_map.sh" "$INFO")
  sketchybar --set "$NAME" icon="$ICON" label="$INFO"
fi
