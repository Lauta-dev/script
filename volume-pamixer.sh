#!/bin/bash

increment="pamixer --increase 5"
decrement="pamixer --decrease 5"
toggle_mute="pamixer --toggle-mute"

case $1 in
  "-i") $increment
  ;;
  "-d") $decrement
  ;;
  "-m") $toggle_mute
  ;;
esac

echo "vvv"

get_volume_human=$(pamixer --get-volume-human)
trigger_notify() {
  dunstify -u low \
    -r 1 \
    -i $1 \
    "Volume: $get_volume_human"
}

if [[ "$get_volume_human" == "muted" ]]; then
  trigger_notify ~/.icons/Papirus-Dark/48x48/status/notification-audio-volume-muted.svg

elif [[ "$get_volume_human" > "0%" && "$get_volume_human" < "25%" ]]; then
  trigger_notify ~/.icons/Papirus-Dark/48x48/status/notification-audio-volume-low.svg

elif [[ "$get_volume_human" > "25%" && "$get_volume_human" < "50%" ]]; then
  trigger_notify ~/.icons/Papirus-Dark/48x48/status/notification-audio-volume-medium.svg

elif [[ "$get_volume_human" > "50%" && "$get_volume_human" < "75%" ]]; then
  trigger_notify ~/.icons/Papirus-Dark/48x48/status/notification-audio-volume-medium.svg

elif [[ "$get_volume_human" > "75%" && "$get_volume_human" < "99%" ]]; then
  trigger_notify ~/.icons/Papirus-Dark/48x48/status/notification-audio-volume-high.svg
fi

