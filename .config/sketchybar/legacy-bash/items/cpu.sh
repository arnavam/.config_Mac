#!/bin/bash

# Label and color are pushed by the mach helper (helper/cpu.h)
cpu_percent=(
  icon="CPU"
  label.font="$FONT:Heavy:12"
  label="--%"
  padding_right=0
  width=55
  update_freq=2
  updates=on
  mach_helper="$HELPER"
)

sketchybar --add item cpu.percent right \
           --set cpu.percent "${cpu_percent[@]}"
