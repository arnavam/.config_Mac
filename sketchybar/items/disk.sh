#!/usr/bin/env bash
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"


disk=(
	label.font="$FONT:Heavy:12"
	icon="DISK"
	update_freq=60
    padding_left=10

	script="$PLUGIN_DIR/disk.sh"
)

sketchybar --add item disk right 		\
		   --set disk "${disk[@]}"
