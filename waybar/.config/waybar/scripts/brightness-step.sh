#!/bin/bash

# Busse und Maximalwerte
declare -A MONITORS
MONITORS[3]=450
MONITORS[4]=100

STATEFILE="/tmp/brightness-level.txt"
STEP=10 # in Prozent

# Initialwert wenn keine Datei existiert
[ ! -f "$STATEFILE" ] && echo 50 >"$STATEFILE"

# Aktuellen Prozentwert lesen
LEVEL=$(<"$STATEFILE")

# Modus prüfen
case "$1" in
increase)
  ((LEVEL += STEP))
  [ "$LEVEL" -gt 100 ] && LEVEL=100
  ;;
decrease)
  ((LEVEL -= STEP))
  [ "$LEVEL" -lt 10 ] && LEVEL=10
  ;;
status)
  # Nur anzeigen
  echo "{\"text\": \"${LEVEL}%\", \"tooltip\": \"Monitorhelligkeit\"}"
  exit 0
  ;;
esac

# Neuen Wert speichern
echo "$LEVEL" >"$STATEFILE"

# Helligkeit berechnen & setzen für jeden Monitor
for bus in "${!MONITORS[@]}"; do
  MAX=${MONITORS[$bus]}
  VALUE=$((LEVEL * MAX / 100))
  ddcutil --bus="$bus" setvcp 10 "$VALUE" >/dev/null 2>&1 &
done

# Modul neu laden
pkill -RTMIN+1 waybar
