#!/usr/bin/env bash

network_down=(
	y_offset=-7
	label.font="$FONT:Heavy:10"
	icon="↓"
	icon.font="$NERD_FONT:Bold:16.0"
	icon.color="$GREEN"
	icon.highlight_color="$BLUE"
)

# network.up runs the script and updates both items
network_up=(
	background.padding_right=-39
	y_offset=7
	label.font="$FONT:Heavy:10"
	icon="↑"
	icon.font="$NERD_FONT:Bold:16.0"
	icon.color="$GREEN"
	icon.highlight_color="$BLUE"
	update_freq=2
	script="$PLUGIN_DIR/network.sh"
)

sketchybar --add item network.down right \
	--set network.down "${network_down[@]}" \
	--add item network.up right \
	--set network.up "${network_up[@]}"
