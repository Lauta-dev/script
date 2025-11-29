#!/bin/bash

# Este script hace uso de ACPID, se usa para apagar la pantalla al bajar la tapa del portatil
# SOLO FUNCIONA EN X11

# Pasos a seguir
# 
# 1. sudo touch /etc/acpi/events/power
# 2. Copiar esto a /etc/acpi/events/power

# event=button/lid
# action=/home/<tu-usuario>/script/power.sh %e

##################################################
echo "$(date) evento: $3" >> /tmp/lid-debug.log
export DISPLAY=:0
export XAUTHORITY=/home/$USER/.Xauthority
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

case "$3" in
  close) xset dpms force off
  ;;
  open) xset dpms force on
  ;;
  *) echo default
  ;;
esac
