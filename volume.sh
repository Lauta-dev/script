#!/bin/bash
arg=$1

subirVolume="amixer set Master 4%+"
bajarVolume="amixer set Master 5%-"
mutear="amixer set Master toggle"

case "$arg" in
  "+") $subirVolume
  ;;
  "-") $bajarVolume
  ;;
  "m") $mutear
  ;;
esac

# Obtener el estado actual del volumen con amixer
volume_status=$(amixer get Master | grep -oP '\d+%' | head -n 1)

# Mostrar notificación con dunstify
dunstify -u low -r 1 -a "volume_change" "Volumen: $volume_status"
