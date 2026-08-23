#!/bin/sh
# Focuses the window "after" the currently focused one, ordered by
# display/x/y position, wrapping around.
yabai -m window --focus "$(yabai -m query --windows | jq -re "sort_by(.display, .frame.x, .frame.y, .id) | map(select(.\"is-visible\" == true and .role != \"AXUnknown\")) | nth(index(map(select(.\"has-focus\" == true))) - 1).id")"
