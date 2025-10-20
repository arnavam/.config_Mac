#!/usr/bin/env bash
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"


memory=(label.font="$FONT:Heavy:12"
	icon="RAM"
	icon.font="$FONT:Bold:16.0"
#	icon.color="$GREEN"
	update_freq=1
	padding_right=10
	script="$PLUGIN_DIR/ram.sh"

)

sketchybar 	--add item memory right 		\
			--set memory "${memory[@]}"
