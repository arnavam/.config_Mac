

separator_right=(
	icon="󰳝"
	icon.font="$NERD_FONT:Regular:20.0"
	background.padding_left=10
	background.padding_right=15
	label.drawing=off
	click_script='sketchybar --trigger toggle_stats'
)

sketchybar  --add item separator_right right \
	          --set separator_right "${separator_right[@]}"
