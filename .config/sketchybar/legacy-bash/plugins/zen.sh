#!/bin/bash

# Items hidden in zen mode. Stats are collapsed through the toggle_stats
# events so separator_right keeps the right icon.
zen_items=(
  apple.logo
  yabai
  separator
  front_app
  battery
  separator_right
)

set_zen_items() {
  args=()
  for item in "${zen_items[@]}"; do
    args+=(--set "$item" drawing="$1")
  done
  sketchybar "${args[@]}" --set calendar icon.drawing="$1"
}

zen_on() {
  set_zen_items off
  sketchybar --trigger hide_stats \
             --set separator_right drawing=off \
             --set spotify.anchor drawing=off popup.drawing=off \
             --set spotify.play updates=off
}

zen_off() {
  set_zen_items on
  # spotify.anchor reappears on the next spotify_change event
  sketchybar --set spotify.play updates=on
}

if [ "$1" = "on" ]; then
  zen_on
elif [ "$1" = "off" ]; then
  zen_off
else
  if [ "$(sketchybar --query apple.logo | jq -r ".geometry.drawing")" = "on" ]; then
    zen_on
  else
    zen_off
  fi
fi
