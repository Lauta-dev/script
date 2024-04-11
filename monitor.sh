#!/bin/bash

# Este script se usa para compartir pantalla con mi televisor.
# Segui este foro de archlinux: https://bbs.archlinux.org/viewtopic.php?pid=1329375#p1329375

X_USER=lauta
export DISPLAY=:0
export XAUTHORITY=/home/$X_USER/.Xauthority
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

HDMI="$(cat /sys/class/drm/card0-HDMI-A-1/status)"

connect() {
  xrandr --output HDMI1 --auto --right-of eDP1
}

disconnect() {
  xrandr --output HDMI1 --off
}

case "$HDMI" in
  "connected")
    connect
    ;;
  "disconnected")
    disconnect
    ;;
  *)
    notify-send "Error" "Este comando no existe"
    ;;
esac

