#!/bin/bash

# Anzahl regulärer Pacman-Updates
pacman_count=$(checkupdates 2>/dev/null | wc -l)

# Anzahl AUR-Updates via yay
aur_count=$(yay -Qua 2>/dev/null | wc -l)

# Icons:  (Arch) und 󰮯 (AUR)
output=""

if [ "$pacman_count" -gt 0 ]; then
  output+=" $pacman_count "
fi

if [ "$aur_count" -gt 0 ]; then
  output+="󰮯 $aur_count"
fi

# Wenn beides 0 ist
if [ -z "$output" ]; then
  output="󰄬 0"
fi

echo "$output"
