#!/bin/sh
# Focuses the next display and warps the mouse to its center.
yabai -m display --focus next &&
eval "$(yabai -m query --displays --display | jq -r '"yabai -m mouse --warp \(.frame.x + .frame.w/2) \(.frame.y + .frame.h/2)"')"
