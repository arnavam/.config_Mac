#!/bin/bash
source "$HOME/.config/sketchybar/plugins/battery.sh"
source "$HOME/.config/sketchybar/colors.sh"
  
battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$FONT:Regular:19.0"
#  icon.color="$YELLOW"
  padding_right=5
  padding_left=0
  label.drawing=on
  update_freq=120
  updates=on
)

sketchybar --add item battery right      \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke
