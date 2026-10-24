#!/bin/bash

wifi=(
  script="$PLUGIN_DIR/wifi.sh"
  icon.font="$NERD_FONT:Regular:16.0"
  label.font="$FONT:Heavy:12"
  label.max_chars=16
  padding_right=8
  updates=on
)

sketchybar --add item wifi right       \
           --set wifi "${wifi[@]}"     \
           --subscribe wifi wifi_change system_woke
