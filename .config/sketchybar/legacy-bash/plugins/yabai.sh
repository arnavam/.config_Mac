#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

# Default JankyBorders active color. Read from bordersrc on every run because
# borders/color_script.sh rewrites it with a random hue.
BORDER_DEFAULT=$(awk -F= '/active_color=/ && !/inactive/ { print $2 }' "$HOME/.config/borders/bordersrc")
BORDER_DEFAULT=${BORDER_DEFAULT:-0xffffffff}

set_border() {
  pgrep -x borders >/dev/null && borders active_color="$1" >/dev/null 2>&1 &
}

window_state() {
  read -r STACK FLOAT FULL_ZOOM PARENT_ZOOM < <(yabai -m query --windows --window 2>/dev/null \
    | jq -r '[.["stack-index"], .["is-floating"], .["has-fullscreen-zoom"], .["has-parent-zoom"]] | @tsv')

  if [ -z "$STACK" ]; then
    sketchybar --set "$NAME" icon=$YABAI_GRID icon.color=$ORANGE label.drawing=off
    return
  fi

  if [ "$STACK" -gt 0 ]; then
    LAST=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
    sketchybar --set "$NAME" icon=$YABAI_STACK icon.color=$RED label.drawing=on label="[$STACK/$LAST]"
    set_border $RED
    return
  fi

  if [ "$FLOAT" = "true" ]; then
    ICON=$YABAI_FLOAT COLOR=$MAGENTA BORDER=$MAGENTA
  elif [ "$FULL_ZOOM" = "true" ]; then
    ICON=$YABAI_FULLSCREEN_ZOOM COLOR=$GREEN BORDER=$GREEN
  elif [ "$PARENT_ZOOM" = "true" ]; then
    ICON=$YABAI_PARENT_ZOOM COLOR=$BLUE BORDER=$BLUE
  else
    ICON=$YABAI_GRID COLOR=$ORANGE BORDER=$BORDER_DEFAULT
  fi

  sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label.drawing=off
  set_border "$BORDER"
}

mouse_clicked() {
  yabai -m window --toggle float
  window_state
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "forced") exit 0
  ;;
  "window_focus") window_state
  ;;
esac
