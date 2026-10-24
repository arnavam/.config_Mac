#!/bin/bash

# No native bluetooth event, so poll. Needs blueutil (brew install blueutil).
bluetooth=(
  script="$PLUGIN_DIR/bluetooth.sh"
  click_script="open 'x-apple.systempreferences:com.apple.BluetoothSettings'"
  icon.font="$NERD_FONT:Regular:16.0"
  label.font="$FONT:Heavy:12"
  label.max_chars=14
  padding_right=4
  update_freq=10
  updates=on
)

sketchybar --add item bluetooth right          \
           --set bluetooth "${bluetooth[@]}"   \
           --subscribe bluetooth system_woke
