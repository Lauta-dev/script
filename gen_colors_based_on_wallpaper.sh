#!/usr/bin/env bash

# Archivos de configuración
PFILE="$HOME/.config/polybar/blocks/colors.ini"
WFILE="$HOME/.cache/hellwal/colors.sh"
RFILE="$HOME/.config/rofi/colors/onedark.rasi"
XSET_CONF="$HOME/.config/xsettingsd/xsettingsd.conf"

WALLPAPER="$1"

if [[ ! -f "$WALLPAPER" ]]; then
  echo "Error: El archivo de imagen no existe."
  exit 1
fi

# 1. Ejecutar Hellwal
if [[ "$MODE" == "light" ]]; then
  echo "asd"
  # hellwal -l --bright-offset 0.1 --check-contrast -i "$WALLPAPER"
  # GTK_DARK="0" 
  # ICON_THEME="Papirus-Light"
  # GTK_THEME="Vimix-light-compact-doder"
  # GS_MODE="prefer-light"
  # kvantummanager --set "VimixDoder" 
else
  echo "asd"
  # hellwal --check-contrast --dark-offset 0.05 --bright-offset 0.8 -i "$WALLPAPER"
  # GTK_DARK="1"
  # ICON_THEME="Papirus-Dark"
  # GTK_THEME="Vimix-dark-compact-doder"
  # GS_MODE="prefer-dark"
  #
  # kvantummanager --set "VimixDoderDark" 
fi 

# # 2. Cargar los colores
# if [[ -e "$WFILE" ]]; then
#   source "$WFILE"
# else
#   echo "Error: No se encontró el archivo de colores."
#   exit 1
# fi
#
# # Actualizar el Panel de LXQt (Sin esto, el panel se queda blanco o no cambia)
# killall lxqt-panel & lxqt-panel & 
#
# # Reiniciar Dunst
# killall dunst 2>/dev/null && dunst &
#
# # Notificar a apps Qt abiertas
# dbus-send --session --dest=org.lxqt.session /org/lxqt/session org.lxqt.session.updateConfig string "all" 
#
# # Wallpaper y Polybar
feh --bg-scale "$WALLPAPER"
# polybar-msg cmd restart
