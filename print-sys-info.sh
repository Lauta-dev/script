#!/bin/bash

# --- VOLUMEN ---
# Si usas pamixer (recomendado para Pipewire/PulseAudio)
VOL=$(pamixer --get-volume-human)
VOLICON=""
# Si prefieres amixer, usa: VOL=$(amixer get Master | grep -Po '\[\d+%\]' | head -1 | tr -d '[]')

# --- WI-FI ---
# Obtiene el nombre de la red conectada
WIFI=$(nmcli -t -f active,ssid dev wifi | grep '^sí' | cut -d':' -f2)

# Si no hay wifi conectado
if [ -z "$WIFI" ]; then
    WIFI="󰤮"
  else
    WIFI="󰤨"
fi

if [[ "$VOL" = "muted" ]]; then
  VOLICON=""

else
  VOLICON="󰕾 $VOL"
fi

# Salida final en una sola línea
echo "$WIFI   $VOLICON"
