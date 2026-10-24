#!/usr/bin/env bash

USED=$(memory_pressure | awk '/free percentage/ { printf "%.0f", 100 - $5 }')
sketchybar --set "$NAME" label="${USED}%"
