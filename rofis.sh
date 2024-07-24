#!/bin/bash

# Script para lanzar rofi sin tener que tocar la configuración del Window Manager
# Rofi themes (No es mío): https://github.com/adi1090x/rofi

dir_rofi="$HOME/.config/rofi"
launch_apps="rofi -show drun -theme $dir_rofi/launchers/type-2/style-2.rasi"
powermenu="$dir_rofi/powermenu/type-2/powermenu.sh"
view_windows="rofi -show window -theme $dir_rofi/launchers/type-2/style-2.rasi"

case "$1" in
  'apps') $launch_apps
  ;;
  'powermenu') $powermenu
  ;;
  'windows') $view_windows
  ;;
esac

