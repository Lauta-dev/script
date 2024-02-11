#!/bin/bash
# inportante para que se ejecute
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

bateria_sin_porsentaje="$(acpi --battery | grep -oP '\d+%' | awk '{print substr($1, 1, length($1)-1)}')"
bateria_con_porsentaje="$(acpi --battery | grep -oP '\d+%' | awk '{print $1}')"

notify() {
  /bin/dunstify -u "$1" "$2" "$3"
}

case "$bateria_sin_porsentaje" in
  100) notify "low" "Batería al: $bateria_con_porsentaje" "Desconecte el cargador"
      ;;
  80) notify "low" "Batería al: $bateria_con_porsentaje"
      ;;
  60) notify "normal" "Batería al: $bateria_con_porsentaje"
      ;;
  40) notify "normal" "Batería al: $bateria_con_porsentaje"
      ;;
  20) notify "critical" "Batería al: $bateria_con_porsentaje"
      ;;
  10) notify "critical" "Batería al: $bateria_con_porsentaje" "Conecte el cargador. Si llega a 5% se apaga la PC"
      ;;
  *) echo "default"
     ;;
esac

