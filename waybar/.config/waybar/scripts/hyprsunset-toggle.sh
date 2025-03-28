#!/bin/bash

PIDFILE="/tmp/hyprsunset.pid"

if [ "$1" = "status" ]; then
  if [ -f "$PIDFILE" ] && kill -0 "$(cat $PIDFILE)" 2>/dev/null; then
    echo '{"text": "", "class": "night"}'
  else
    echo '{"text": "☀", "class": "day"}'
  fi
  exit 0
fi

# Toggle
if [ -f "$PIDFILE" ] && kill -0 "$(cat $PIDFILE)" 2>/dev/null; then
  kill "$(cat $PIDFILE)" && rm -f "$PIDFILE"
else
  hyprsunset -t 4000 &
  echo $! >"$PIDFILE"
fi

pkill -RTMIN+1 waybar
