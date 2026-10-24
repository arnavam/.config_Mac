#!/usr/bin/env bash

stats=(
	cpu.percent
	memory
	disk
	network.up
	network.down
)

set_stats() {
	args=()
	for item in "${stats[@]}"; do
		args+=(--set "$item" drawing="$1")
	done

	sketchybar "${args[@]}" --set separator_right icon="$2"
}

hide_stats() { set_stats off "󰳝"; }
show_stats() { set_stats on "󰳟"; }

toggle_stats() {
	if [ "$(sketchybar --query cpu.percent | jq -r .geometry.drawing)" = "on" ]; then
		hide_stats
	else
		show_stats
	fi
}

case "$SENDER" in
"hide_stats") hide_stats ;;
"show_stats") show_stats ;;
"toggle_stats") toggle_stats ;;
esac
