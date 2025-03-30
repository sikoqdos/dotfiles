#!/bin/bash

chosen=$(printf \
  "<span color='#ff5555'>󰌾</span>  Lock\n\
<span color='#f1fa8c'>󰑓</span>  Restart\n\
<span color='#8be9fd'>󰐥</span>  Power Off\n\
<span color='#50fa7b'>󰤄</span>  Suspend" |
  rofi -dmenu -markup-rows -theme ~/dotfiles/waybar/.config/waybar/scripts/power.rasi)

case "$chosen" in
*"Lock") hyprlock ;;
*"Power Off") poweroff ;;
*"Suspend") systemctl suspend-then-hibernate ;;
*"Restart") reboot ;;
*) exit 1 ;;
esac
