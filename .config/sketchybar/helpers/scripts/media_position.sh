#!/bin/bash

# Prints "<elapsed>|<duration>" in whole seconds. media-control reports the
# elapsed time at .timestamp, so extrapolate to now while playing.
media-control get | jq -r '
  if . == null or .duration == null then "0|0" else
    (if .playing then (now - (.timestamp | fromdateiso8601)) * (.playbackRate // 1) else 0 end
      + (.elapsedTime // 0)) as $e
    | "\($e | floor)|\(.duration | floor)"
  end'
