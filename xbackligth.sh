#!/bin/bash
# Se necesita instalar xorg-xbacklight
# Sudo pacman -S xorg-xbacklight

inc="xbacklight -inc 2"
dec="xbacklight -dec 2"

case "$1" in
  "-i") $inc
  ;;
  "-d") $dec
  ;;
  *) echo default
  ;;
esac

# Obtener el estado actual del brillo con xbacklight y convertir a entero
brightness_status=$(printf "%.0f" $(xbacklight))

# Mostrar notificación con dunstify y reemplazar la anterior
dunstify -u low -r 2 -a "brightness_change" "Brillo: $brightness_status"

