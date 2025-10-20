#!/bin/bash

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

DRAWING=on
COLOR=$WHITE
case ${PERCENTAGE} in
  9[0-9]|100) ICON=$BATTERY_100; DRAWING=off; COLOR=$WHITE
  ;;
  [6-8][0-9]) ICON=$BATTERY_75; DRAWING=off; COLOR=$YELLOW
  ;;
  [3-5][0-9]) ICON=$BATTERY_50 ; COLOR=$YELLOW
  ;;
  [1-2][0-9]) ICON=$BATTERY_25; COLOR=$ORANGE
  ;;
  *) ICON=$BATTERY_0; COLOR=$RED
esac

if [[ $CHARGING != "" ]]; then
  ICON=$BATTERY_CHARGING
  DRAWING=on
fi

sketchybar --set "$NAME"   icon.color="$COLOR" icon="$ICON" label="$PERCENTAGE%" 

