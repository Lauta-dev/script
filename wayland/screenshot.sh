#!/bin/bash

# ArchLinux Article: https://wiki.archlinux.org/title/Screen_capture#Wayland
# Deps
#   - slurp
#   - grim

pic_dir=`xdg-user-dir PICTURES`
screenshot_name="screenshot $(date '+%d %A %Y at %H-%M-%S').png"
save_to="$pic_dir/$screenshot_name"

opt1=" Capture Desktop"
opt2=" Capture Area"
opt3=" Capture Window"

exec_notify () {
  dunstify "$1" "$2" -I "$3"
}

choise=$(echo -e "$opt1\n$opt2\n$opt3" | rofi -dmenu -theme ~/.config/rofi/powermenu/type-1/style-2.rasi)
if [[ "$choise" == "$opt1" ]]; then
  grim "$save_to"
  exec_notify "$opt1" "$screenshot_name" "$save_to" 

elif [[ "$choise" == "$opt2" ]]; then
  slurp | grim -g - "$save_to"
  exec_notify "$opt2" "$screenshot_name" "$save_to" 

elif [[ "$choise" == "$opt3" ]]; then
  
  if [[ "$XDG_SESSION_DESKTOP" == "hyprland" ]]; then
    hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - $save_to
    exec_notify "$opt3" "$screenshot_name" "$save_to" 

  elif [[ "$XDG_SESSION_DESKTOP" == "sway" ]]; then
    swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | grim -g - "$save_to"
    exec_notify "$opt3" "$screenshot_name" "$save_to" 
  
  else
    echo "no"
  fi
fi

