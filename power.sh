#!/bin/bash
export DISPLAY=:0

# Detectar usuario de sesión X activo
XUSER="lautaro"
export XAUTHORITY=/home/$XUSER/.Xauthority
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $XUSER)/bus

case "$3" in
  close) su "$XUSER" -c "xset dpms force off" ;;
  open)  su "$XUSER" -c "xset dpms force on"  ;;
  *)     echo default ;;
esac
