#!/bin/bash
general_style="$HOME/.config/rofi/launchers/type-4/style-1.rasi"

# 1. Obtenemos el JSON y lo formateamos para Rofi en un solo paso
# Creamos líneas tipo: "ID Titulo"
json=$(rmpc queue)

current_song=$(rmpc song)
get_title=$(echo "$current_song" | jq -r '"\(.metadata.title)"' )

short_title=$(printf "%.20s" "$get_title")

# Usamos jq para generar la lista completa de una vez
items=$(echo "$json" | jq -r 'to_entries | .[] | "\(.key + 1) \(.value.metadata.title)"')

# 2. Mostramos el menú
CHOICE=$(echo "$items" | rofi -dmenu -theme "$general_style" -p "$short_title")

# 3. Si el usuario cancela (ESC), salimos
[ -z "$CHOICE" ] && exit 0

# 4. Extraemos el ID (primer número) y reproducimos
ID=$(echo "$CHOICE" | cut -d' ' -f1)
mpc play "$ID"
