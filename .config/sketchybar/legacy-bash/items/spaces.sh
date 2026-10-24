#!/bin/bash

# Space items are created by plugins/spaces_refresh.sh from the live yabai
# space list (and own the spaces bracket), so they stay in sync when spaces are created or destroyed.
# Left click focuses a space, right click destroys it.
# New space by left clicking separator (>)

separator=(
  icon=􀆊
  icon.font="$FONT:Heavy:16.0"
  padding_left=15
  padding_right=15
  label.drawing=off
  associated_display=active
  click_script='yabai -m space --create && sketchybar --trigger spaces_refresh'
  icon.color=$WHITE
)

sketchybar --add event spaces_refresh                       \
           --add item separator left                        \
           --set separator "${separator[@]}"                \
                                                            \
           --add item spaces.manager left                   \
           --set spaces.manager drawing=off updates=on      \
                                script="$PLUGIN_DIR/spaces_refresh.sh" \
           --subscribe spaces.manager spaces_refresh display_change

"$PLUGIN_DIR/spaces_refresh.sh"
