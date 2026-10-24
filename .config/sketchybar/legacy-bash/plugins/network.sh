#!/usr/bin/env bash

IFACE=$(route get default 2>/dev/null | awk '/interface:/ { print $2 }')
[ -z "$IFACE" ] && IFACE=en0

read -r DOWN UP < <(ifstat -i "$IFACE" -b 0.1 1 | tail -n1 | awk '{ printf "%d %d", $1, $2 }')
DOWN=${DOWN:-0}
UP=${UP:-0}

format() {
	if [ "$1" -gt 999 ]; then
		awk -v v="$1" 'BEGIN { printf "%.0f Mb", v / 1000 }'
	else
		echo "$1 kb"
	fi
}

highlight() { [ "$1" -gt 0 ] && echo on || echo off; }

sketchybar --set network.down label="$(format "$DOWN")" icon.highlight="$(highlight "$DOWN")" \
	--set network.up label="$(format "$UP")" icon.highlight="$(highlight "$UP")"
