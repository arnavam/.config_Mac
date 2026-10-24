#!/bin/bash

# Event driven by wifi_change, no polling.
# macOS 14.4+ redacts the SSID for processes without Location access, so
# only the connection icon is shown in that case.
WIFI_ON=󰖩
WIFI_OFF=󰖪
HOTSPOT=󰀂

IFACE=$(networksetup -listallhardwareports | awk '/Wi-Fi/ { getline; print $2 }')
IFACE=${IFACE:-en0}

# wifi_change can fire before DHCP finishes, so wait once for an address
if ! ipconfig getifaddr "$IFACE" >/dev/null; then
  sleep 2
  if ! ipconfig getifaddr "$IFACE" >/dev/null; then
    sketchybar --set "$NAME" icon=$WIFI_OFF label="" label.drawing=off
    exit 0
  fi
fi

# iPhone hotspots hand out 172.20.10.0/28, Android ones tag DHCP with ANDROID_METERED
PACKET=$(ipconfig getpacket "$IFACE")
ICON=$WIFI_ON
if grep -q 'router (ip_mult): {172\.20\.10\.' <<< "$PACKET" || grep -q 'ANDROID_METERED' <<< "$PACKET"; then
  ICON=$HOTSPOT
fi

SSID=$(ipconfig getsummary "$IFACE" | awk -F ' SSID : ' '/ SSID : / { print $2 }')

if [ -z "$SSID" ] || [ "$SSID" = "<redacted>" ]; then
  sketchybar --set "$NAME" icon=$ICON label="" label.drawing=off
else
  sketchybar --set "$NAME" icon=$ICON label="$SSID" label.drawing=on
fi
