#!/bin/bash

# Streams now-playing info for any app through media-control (the native
# media_change event is broken since macOS 15.4) and triggers media_update.
# Fields are joined with the ASCII unit separator so empty ones survive read.
PIDFILE=/tmp/sketchybar_media_stream.pid

# Replace a previous instance (sketchybar reload) and take its children with it
if [ -f "$PIDFILE" ]; then
  OLD=$(cat "$PIDFILE")
  pkill -P "$OLD" 2>/dev/null
  kill "$OLD" 2>/dev/null
fi
echo $$ > "$PIDFILE"
trap 'pkill -P $$ 2>/dev/null' EXIT TERM

SEP=$'\x1f'
COVER_DIR=/tmp/sketchybar_media
mkdir -p "$COVER_DIR"
LAST_KEY=""
COVER=""

media-control stream --no-diff | while IFS= read -r line; do
  fields=$(jq -r '.payload | [
      .title // "", .artist // "", .album // "",
      (if .playing == null then "none" else (.playing | tostring) end),
      .bundleIdentifier // "", (.duration // 0 | floor | tostring),
      (.artworkMimeType // ""),
      (.shuffleMode // 1 | tostring), (.repeatMode // 1 | tostring)
    ] | join("\u001f")' <<< "$line" 2>/dev/null) || continue

  IFS=$SEP read -r title artist album playing bundle duration mime shuffle repeat <<< "$fields"

  # Decode artwork only when the track changes; a new path per track makes
  # sketchybar load the new image instead of a cached one
  key="$title$SEP$album"
  if [ "$key" != "$LAST_KEY" ]; then
    LAST_KEY=$key
    rm -f "$COVER_DIR"/cover_* 2>/dev/null
    COVER=""
    if [ -n "$mime" ]; then
      # sketchybar picks the image decoder from the extension, and the
      # reported mime type is not reliable, so sniff the PNG signature
      RAW="$COVER_DIR/cover_raw"
      jq -r '.payload.artworkData // empty' <<< "$line" | base64 -d > "$RAW" 2>/dev/null
      EXT=jpg
      [ "$(head -c 4 "$RAW" | xxd -p)" = "89504e47" ] && EXT=png
      COVER="$COVER_DIR/cover_$(date +%s)_$RANDOM.$EXT"
      mv "$RAW" "$COVER" 2>/dev/null || COVER=""
    fi
  fi

  sketchybar --trigger media_update \
    title="$title" artist="$artist" album="$album" playing="$playing" \
    bundle="$bundle" duration="$duration" cover="$COVER" \
    shuffle="$shuffle" repeat="$repeat"
done
