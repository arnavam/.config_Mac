#!/bin/sh
# toggle between configured (gaps, sketchybar, macOS menu bar autohidden)
# and minimal (all 0, sketchybar hidden, macOS menu bar shown)
menubar_autohide() {
  osascript -e "tell application \"System Events\" to set autohide menu bar of dock preferences to $1"
}

if [ "$(yabai -m config window_gap)" = "0" ]; then
  menubar_autohide true
  yabai -m config external_bar off:40:0 top_padding 12 bottom_padding 10 left_padding 10 right_padding 10 window_gap 6
  sketchybar --bar hidden=off
else
  menubar_autohide false
  yabai -m config external_bar off:0:0 top_padding 0 bottom_padding 0 left_padding 0 right_padding 0 window_gap 0
  sketchybar --bar hidden=on
fi
