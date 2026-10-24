#!/usr/bin/env bash

disk=(
	icon="DISK"
	label.font="$FONT:Heavy:12"
	update_freq=60
	padding_left=10
	script="$PLUGIN_DIR/disk.sh"
)

sketchybar --add item disk right \
	--set disk "${disk[@]}"
