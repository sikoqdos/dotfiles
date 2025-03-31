#!/bin/bash

# Anzahl regulärer Pacman-Updates
pacman_count=$(pachman -Qua 2>/dev/null | wc -l)

# Anzahl AUR-Updates via yay
aur_count=$(yay -Qu 2>/dev/null | wc -l)

# Icons:  (Arch) und 󰮯 (AUR)
output=""

if [ "$pacman_count" -gt 0 ]; then
  output+=" $pacman_count "
  if [ "$aur_count" -gt 0 ]; then
    output+=" 󰮯 $aur_count"
  fi
elif [ "$aur_count" -gt 0 ]; then
  output="󰮯 $aur_count"
fi

# Wenn beides 0 ist
if [ -z "$output" ]; then
  output="󰄬 0"
fi

echo "$output"
