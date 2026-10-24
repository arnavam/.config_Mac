#!/bin/bash

update() {
  sketchybar --animate tanh 20 --set "$NAME" icon.highlight="$SELECTED"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    yabai -m space --destroy "$SID"
    sketchybar --trigger spaces_refresh
  else
    yabai -m space --focus "$SID" 2>/dev/null
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
