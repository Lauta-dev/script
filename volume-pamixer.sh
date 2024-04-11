#!/bin/bash

increment="pamixer --increase 5"
decrement="pamixer --decrease 5"
toggle_mute="pamixer --toggle-mute"

case $1 in
  "-i") $increment
  ;;
  "-d") $decrement
  ;;
  "-m") $toggle_mute
  ;;
esac

# Mostrar notificación con dunstify
dunstify -u low \
  -r 1 \
  -a "volume_change" "Volumen: $(pamixer --get-volume-human)"
