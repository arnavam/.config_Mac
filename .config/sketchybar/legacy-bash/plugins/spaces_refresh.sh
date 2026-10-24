#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

WANT=$(yabai -m query --spaces | jq -r '.[].index' | sort -n)
HAVE=$(sketchybar --query bar | jq -r '.items[] | select(test("^space\\.[0-9]+$")) | ltrimstr("space.")' | sort -n)

[ "$WANT" = "$HAVE" ] && exit 0

args=()

for sid in $HAVE; do
  grep -qx "$sid" <<< "$WANT" || args+=(--remove "space.$sid")
done

for sid in $WANT; do
  grep -qx "$sid" <<< "$HAVE" && continue

  space=(
    associated_space=$sid
    icon=$sid
    icon.padding_left=10
    icon.padding_right=15
    padding_left=2
    padding_right=2
    icon.highlight_color=$RED
    label.drawing=off
    script="$PLUGIN_DIR/space.sh"
  )

  args+=(--add space "space.$sid" left
         --set "space.$sid" "${space[@]}"
         --subscribe "space.$sid" mouse.clicked)
done

sketchybar "${args[@]}"

# Keep spaces in index order and in front of the separator
order=()
for sid in $WANT; do
  order+=(--move "space.$sid" before separator)
done
sketchybar "${order[@]}"

# Brackets resolve their regex once, so rebuild it to include new spaces
bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.border_width=2
  background.drawing=on
)

sketchybar --remove spaces 2>/dev/null
sketchybar --add bracket spaces '/space\.[0-9]+/' \
           --set spaces "${bracket[@]}"
