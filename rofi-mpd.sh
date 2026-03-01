#!/bin/bash

# --- CONFIGURACIÓN ---
CACHE_DIR="$HOME/.cache/rofi-covers"
STYLE="$HOME/dev/script/rofi-themes/select-music.rasi"
MUSIC_DIR="$HOME/Música"

mkdir -p "$CACHE_DIR"

# --- FUNCIÓN DE CACHÉ ---
# Optimización de ffmpeg: 
# 1. -vframes 1: Solo procesa el primer frame encontrado.
# 2. -q:v 2: Mantiene buena calidad pero procesa más rápido.
# 3. mjpeg: Forzamos formato de salida rápido.
get_cover() {
    local id="$1"
    local file="$2"
    local output="$CACHE_DIR/$id.png"

    if [ ! -f "$output" ]; then
        ffmpeg -y -i "$MUSIC_DIR/$file" \
            -vframes 1 -an \
            -vf "scale=500:500:force_original_aspect_ratio=increase,crop=500:500" \
            -q:v 2 "$output" -loglevel quiet &
    fi
}

# 1. Preparar carátula de la canción ACTUAL (antes de abrir Rofi)
read -r current_id current_file <<< "$(mpc current -f "%id% %file%")"
get_cover "$current_id" "$current_file"
wait # Esperamos un instante solo para la actual si es que no existía

# 2. Lanzar Rofi
items=$(mpc playlist -f "%position% %title%")
status="▶ $(mpc current -f '%title%')"
COVER="$CACHE_DIR/$current_id.png"

# 3. Lanzar Rofi
# Optimizamos el theme-str para que sea más legible
CHOICE=$(echo -e "$items" | rofi \
  -dmenu \
  -theme "$STYLE" \
  -theme-str "listview { lines: 8; }" \
  -theme-str "imagebox { background-image: url(\"$COVER\", width); }" \
  -theme-str "entry {placeholder: ' $status';}"
)

# Si cancela, salimos
[[ -z "$CHOICE" ]] && exit 0

# 3. Acción: Cambiar de canción
POS=$(echo "$CHOICE" | cut -d' ' -f1)
mpc play "$POS"

# 4. Preparar carátula de la NUEVA canción (en segundo plano)
# La función ya tiene el '&' interno, así que no bloquea el cierre del script
read -r next_id next_file <<< "$(mpc current -f "%id% %file%")"
get_cover "$next_id" "$next_file"
