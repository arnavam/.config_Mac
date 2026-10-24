#!/bin/bash

# This month's calendar, then today's remaining events when icalBuddy exists
cal | sed 's/_//g; s/[[:space:]]*$//'
if command -v icalBuddy >/dev/null; then
  EVENTS=$(icalBuddy -n -nc -npn -ea -iep "title,datetime" -po "datetime,title" -ps "| |" -tf "%H:%M" -b "" eventsToday 2>/dev/null | head -n 5)
  [ -n "$EVENTS" ] && { echo ""; echo "$EVENTS"; }
fi
exit 0
