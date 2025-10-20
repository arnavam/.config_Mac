#!/usr/bin/env bash
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"


network_down=(
	y_offset=-7
	label.font="$FONT:Heavy:10"
	icon="↓"
	icon.font="$NERD_FONT:Bold:16.0"
	icon.color="$GREEN"
	icon.highlight_color="$BLUE"
	update_freq=1
    # background.padding_left=-20

)

network_up=(
	background.padding_right=-39
	y_offset=7
	label.font="$FONT:Heavy:10"
	icon="↑"
	icon.font="$NERD_FONT:Bold:16.0"
	icon.color="$GREEN"
	icon.highlight_color="$BLUE"
	update_freq=1
	script="$PLUGIN_DIR/network.sh"
)

sketchybar 	--add item network.down right 			    \
			--set network.down "${network_down[@]}" 	\
			--add item network.up right 				\
			--set network.up "${network_up[@]}"
