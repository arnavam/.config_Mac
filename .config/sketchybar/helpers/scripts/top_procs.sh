#!/bin/bash

# Top 5 processes by cpu or mem: "<percent>%  <name>" per line
# comm can contain spaces, so pcpu / pmem are read from the end of the line
case "$1" in
  mem) SORT=-m; OFFSET=0 ;;
  *) SORT=-r; OFFSET=1 ;;
esac

ps -Aceo pid,comm,pcpu,pmem "$SORT" | awk -v o="$OFFSET" 'NR > 1 && NR <= 6 {
  name = $2; for (i = 3; i < NF - 1; i++) name = name " " $i
  printf "%5.1f%%  %s\n", $(NF - o), substr(name, 1, 24)
}'
