#!/bin/bash

# Script para lanzar rofi sin tener que tocar la configuración del Window Manager
# Rofi themes (No es mío): https://github.com/adi1090x/rofi

arg=$1

dir_rofi="$HOME/.config/rofi"
launch_apps="rofi -show drun -theme $dir_rofi/launchers/type-3/style-1.rasi"
powermenu="$dir_rofi/applets/bin/powermenu.sh"

case "$arg" in
  'apps') $launch_apps
  ;;
  'powermenu') $powermenu
  ;;
esac

