#!/bin/bash

# One line per popup row for items/battery.lua
BATT=$(pmset -g batt)
IOREG=$(ioreg -rn AppleSmartBattery)
value() { awk -v k="\"$1\"" '$1 == k { print $3; exit }' <<< "$IOREG"; }

SOURCE=$(grep -o "'.*'" <<< "$BATT" | tr -d "'")
STATE=$(awk -F'; ' 'NR==2 { print $2 }' <<< "$BATT")
REMAINING=$(grep -Eo '[0-9]+:[0-9]+ remaining' <<< "$BATT")
CYCLES=$(value CycleCount)
MAX=$(value AppleRawMaxCapacity)
DESIGN=$(value DesignCapacity)

echo "Source: ${SOURCE:-unknown}"
echo "State: ${STATE:-unknown}"
echo "Time: ${REMAINING:-calculating}"
[ -n "$CYCLES" ] && echo "Cycles: $CYCLES"
[ -n "$MAX" ] && [ -n "$DESIGN" ] && [ "$DESIGN" -gt 0 ] && echo "Health: $((MAX * 100 / DESIGN))%"
