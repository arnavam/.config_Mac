#!/usr/bin/env bash

memory=(
	icon="RAM"
	icon.font="$FONT:Bold:16.0"
	label.font="$FONT:Heavy:12"
	update_freq=5
	padding_right=10
	script="$PLUGIN_DIR/ram.sh"
)

sketchybar --add item memory right \
	--set memory "${memory[@]}"
