#!/bin/bash
# Se necesita instalar brightnessctl
# Sudo pacman -S brightnessctl xorg-xbacklight

inc="brightnessctl s 2%+"
dec="brightnessctl s 2%-"

case "$1" in
  "-i") $inc
  ;;
  "-d") $dec
  ;;
  *) echo default
  ;;
esac

# Obtener el estado actual del brillo con xbacklight y convertir a entero
brightness_status=$(brightnessctl -m | grep -oP '\d+%')

trigger_notify() {
  dunstify \
    -r 2 \
    -i $1 \
    "" \
    "<span font='12' weight='bold'>Brillo: $brightness_status</span>\n&#160;" 
}

if [[ "$brightness_status" > "0" && "$brightness_status" < "25" ]]; then
  trigger_notify ~/.local/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-low.svg

elif [[ "$brightness_status" > "25" && "$brightness_status" < "50" ]]; then
  trigger_notify ~/.local/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-low.svg

elif [[ "$brightness_status" > "50" && "$brightness_status" < "75" ]]; then
  trigger_notify ~/.local/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-high.svg

elif [[ "$brightness_status" > "75" && "$brightness_status" < "99" ]]; then
  trigger_notify ~/.local/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-full.svg

elif [[ "$brightness_status" == "100%" ]]; then
  trigger_notify ~/.local/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-full.svg
fi

