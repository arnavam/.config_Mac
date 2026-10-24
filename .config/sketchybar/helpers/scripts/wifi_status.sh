#!/bin/bash

# Prints "<off|on|hotspot>|<interface>" for items/wifi.lua.
# iPhone hotspots hand out 172.20.10.0/28, Android ones tag DHCP with
# ANDROID_METERED. The SSID is not used: macOS 14.4+ redacts it for
# processes without Location access.
IFACE=$(route get default 2>/dev/null | awk '/interface:/ { print $2 }')
WIFI=$(networksetup -listallhardwareports | awk '/Wi-Fi/ { getline; print $2 }')
WIFI=${WIFI:-en0}
IFACE=${IFACE:-$WIFI}

# wifi_change can fire before DHCP finishes, so wait once for an address
if ! ipconfig getifaddr "$WIFI" >/dev/null; then
  sleep 2
  ipconfig getifaddr "$WIFI" >/dev/null || { echo "off|$IFACE"; exit 0; }
fi

KIND=on
if ipconfig getpacket "$WIFI" | grep -qE 'router \(ip_mult\): \{172\.20\.10\.|ANDROID_METERED'; then
  KIND=hotspot
fi

echo "$KIND|$IFACE"
