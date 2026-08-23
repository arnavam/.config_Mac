#!/bin/sh
# Focuses the window "before" the currently focused one, using the same
# visible-window ordering as focus-window-backward.sh, wrapping around.
yabai -m window --focus "$(yabai -m query --windows | jq -re "sort_by(.display, .space, .frame.x, .frame.y, .id) | map(select(.\"is-visible\" == true and .role != \"AXUnknown\")) | reverse | nth(index(map(select(.\"has-focus\" == true))) - 1).id")"
