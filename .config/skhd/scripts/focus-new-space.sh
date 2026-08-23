#!/bin/sh
# Creates a new space, moves the current window into it, and focuses it.
index="$(yabai -m query --spaces --display | jq 'map(select(."is-native-fullscreen" == false))[-1].index')"
yabai -m space --create &&
yabai -m window --space "${index}" &&
yabai -m space --focus "${index}"
