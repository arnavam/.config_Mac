#!/bin/bash

# One line per popup row for items/wifi.lua
IFACE=$(route get default 2>/dev/null | awk '/interface:/ { print $2 }')
GATEWAY=$(route get default 2>/dev/null | awk '/gateway:/ { print $2 }')
IP=$(ipconfig getifaddr "${IFACE:-en0}")
WIFI=$(networksetup -listallhardwareports | awk '/Wi-Fi/ { getline; print $2 }')

if [ -z "$IP" ]; then
  echo "Disconnected"
  exit 0
fi

KIND="Wi-Fi"
[ "$IFACE" != "$WIFI" ] && KIND="Wired"
ipconfig getpacket "$IFACE" 2>/dev/null | grep -qE 'router \(ip_mult\): \{172\.20\.10\.|ANDROID_METERED' && KIND="Hotspot"

echo "Type: $KIND"
echo "Interface: $IFACE"
echo "IP: $IP"
echo "Router: ${GATEWAY:-none}"
