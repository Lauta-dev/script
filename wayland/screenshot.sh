#!/bin/bash

# ArchLinux Article: https://wiki.archlinux.org/title/Screen_capture#Wayland
# Deps
#   - slurp
#   - grim

pic_dir=`xdg-user-dir PICTURES`
screenshot_name="screenshot $(date '+%d %A %Y at %H-%M-%S').png"
save_to="$pic_dir/$screenshot_name"

opt1="  Capturar escritorio"
opt2="  Capturar area"
opt3="  Capturar ventana"

list_col=2
list_row=6
general_style="$HOME/.config/hypr/launcher/style.rasi"

rofi_cmd() {
  rofi $1 \
    -theme "${general_style}"
}

launch_notify () {
  dunstify "$1" "$2" -I "$3"
}

run_rofi() {
  echo -e "$opt1\n$opt2\n$opt3" | rofi_cmd "-dmenu"
}

choise=$(run_rofi)
if [[ "$choise" == "$opt1" ]]; then
  grim "$save_to" | wl-copy
  launch_notify "$opt1" "$screenshot_name" "$save_to" 

elif [[ "$choise" == "$opt2" ]]; then
  slurp | grim -g - "$save_to" | wl-copy
  launch_notify "$opt2" "$screenshot_name" "$save_to" 

elif [[ "$choise" == "$opt3" ]]; then
  if [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
    sleep 1
    hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - "$save_to"  | wl-copy
    launch_notify "$opt3" "$screenshot_name" "$save_to" 

  elif [[ "$XDG_SESSION_DESKTOP" == "sway" ]]; then
    swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | grim -g - "$save_to"
    launch_notify "$opt3" "$screenshot_name" "$save_to" 
  
  else
    echo "no"
  fi
fi

