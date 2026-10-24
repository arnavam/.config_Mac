#!/bin/bash

separator_right=(
	icon="󰳝"
	icon.font="$NERD_FONT:Regular:20.0"
	background.padding_left=10
	background.padding_right=15
	label.drawing=off
	click_script='sketchybar --trigger toggle_stats'
)

sketchybar --add event hide_stats \
	--add event show_stats \
	--add event toggle_stats \
	--add item animator right \
	--set animator drawing=off \
	updates=on \
	script="$PLUGIN_DIR/toggle_stats.sh" \
	--subscribe animator hide_stats show_stats toggle_stats \
	--add item separator_right right \
	--set separator_right "${separator_right[@]}"
