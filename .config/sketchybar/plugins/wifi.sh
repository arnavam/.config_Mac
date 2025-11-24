#!/usr/bin/env sh

# CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID=$(wdutil info | grep 'SSID:' | awk -F': ' '{print $2}')
CURR_TX=$(wdutil info | grep 'Tx Rate:' | awk -F': ' '{print $2}')

if [ "$SSID" = "" ]; then
  sketchybar --set $NAME  icon=󰖪
else
  sketchybar --set $NAME label="$SSID (${CURR_TX}Mbps)" icon=󰖩
fi