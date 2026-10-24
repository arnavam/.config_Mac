#!/bin/bash

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

BATT=$(pmset -g batt)
PERCENTAGE=$(echo "$BATT" | grep -Eo "[0-9]+%" | cut -d% -f1)

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

# Label only shows when battery is low or charging
LABEL_DRAWING=on
case ${PERCENTAGE} in
  9[0-9]|100) ICON=$BATTERY_100; LABEL_DRAWING=off; COLOR=$WHITE
  ;;
  [6-8][0-9]) ICON=$BATTERY_75; LABEL_DRAWING=off; COLOR=$YELLOW
  ;;
  [3-5][0-9]) ICON=$BATTERY_50; COLOR=$YELLOW
  ;;
  [1-2][0-9]) ICON=$BATTERY_25; COLOR=$ORANGE
  ;;
  *) ICON=$BATTERY_0; COLOR=$RED
esac

if [[ $BATT == *"AC Power"* ]]; then
  ICON=$BATTERY_CHARGING
  LABEL_DRAWING=on
fi

sketchybar --set "$NAME" icon.color="$COLOR" icon="$ICON" label="$PERCENTAGE%" label.drawing="$LABEL_DRAWING"
