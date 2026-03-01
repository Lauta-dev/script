#!/bin/bash

# Script para lanzar rofi sin tener que tocar la configuración del Window Manager
# Rofi themes (No es mío): https://github.com/adi1090x/rofi

# menu, menu-v2,v3,v4
APP_LAUNCHER_MENU="menu"

APP_LAUNCHER_THEME="$HOME/dev/script/rofi-themes/$APP_LAUNCHER_MENU.rasi"
WINDOW_THEME="$HOME/dev/script/rofi-themes/windows.rasi"

app_launcher() {
  CURRENT_WALL=$(cat /tmp/current_wallpaper)

  bg_image=""

  if [[ $APP_LAUNCHER_MENU == "menu" ]]; then
    bg_image="imagebox { background-image: url('$CURRENT_WALL', height); }"
    bg_image+="window { width: 60em; }"
  
  elif [[ $APP_LAUNCHER_MENU == "menu-v3" ]]; then
    bg_image="inputbar { background-image: url('$CURRENT_WALL', width); }"
  fi

  rofi -show drun \
    -theme "$APP_LAUNCHER_THEME" \
    -theme-str "$bg_image"
}

case "$1" in
  'apps') app_launcher 
  ;;
  'clip') clipcat-menu
  ;;
  'wall') /bin/bash ~/dev/script/wall
  ;;
  'cpupower') /bin/bash ~/dev/script/rofi-cpupower.sh
  ;;
  'powermenu') /bin/bash ~/dev/script/powermenu
  ;;
  'mpd') /bin/bash ~/dev/script/rofi-mpd.sh
  ;;
  'window') rofi -show window -theme "$WINDOW_THEME"
esac
