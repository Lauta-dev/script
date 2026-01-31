#!/bin/bash

# Este script hace uso de ACPID, se usa para apagar la pantalla al bajar la tapa del portatil
# SOLO FUNCIONA EN WAYLAND

# Pasos a seguir
# 
# 1. sudo touch /etc/acpi/events/power
# 2. Copiar esto a /etc/acpi/events/power

# event=button/lid
# action=/home/<tu-usuario>/script/power.sh %e

##################################################

monitor="eDP-1"

case "$3" in
  close) su work -u "niri msg output eDP-1 off"
  ;;
  open) su work -u "niri msg output eDP-1 on"

  ;;
  *) echo default
  ;;
esac
