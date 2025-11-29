#!/bin/bash

# Script para lanzar rofi sin tener que tocar la configuración del Window Manager
# Rofi themes (No es mío): https://github.com/adi1090x/rofi

list_col=1
list_row=8
general_style="$HOME/.config/hypr/launcher/style.rasi"

rofi_cmd() {
  rofi $1 \
    -theme-str "configuration { modi:'drun'; show-icons:true; }" \
    -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str "mainbox {children: ['inputbar', 'listview'];}" \
    -theme-str "window {width: 600;}" \
    -theme "${general_style}"
}

rofi_clip() {
  rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}' \
    -theme-str "configuration { show-icons:false; }" \
    -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str "mainbox {children: ['inputbar', 'listview'];}" \
    -theme-str "window {width: 800;}" \
    -theme-str "element {border-radius: 10px;}" \
    -theme "${general_style}"
}

case "$1" in
  'apps') rofi_cmd "-show drun"
  ;;
  'clip') rofi_clip
  ;;
esac
