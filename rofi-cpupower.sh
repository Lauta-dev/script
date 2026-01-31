#!/bin/bash

general_style="$HOME/.config/rofi/launchers/type-4/style-1.rasi"

# 1. Obtener la lista de gobernadores disponibles
# xargs elimina espacios en blanco sobrantes
GOVERNORS_LIST=$(cpupower frequency-info -g | grep "available cpufreq governors" | cut -d ":" -f 2 | xargs)

# 2. Obtener el gobernador activo actualmente
CURRENT_GOV=$(cpupower frequency-info -p | grep "The governor" | awk -F '"' '{print $2}')

# 3. Obtener la frecuencia media actual (para el prompt)
AVG_FREQ=$(cpupower monitor -m "Mperf" sleep 0.1 | tail -n 1 | awk '{print $4}' | xargs)
[ -z "$AVG_FREQ" ] && AVG_FREQ=$(grep "cpu MHz" /proc/cpuinfo | head -n 1 | cut -d ":" -f 2 | xargs | cut -d "." -f 1)

# 4. Construir la lista para Rofi y calcular el índice resaltado
MENU_OPTIONS=""
SELECTED_INDEX=0
COUNT=0

for GOV in $GOVERNORS_LIST; do
    # Si el gobernador es el actual, lo marcamos visualmente (opcional)
    if [ "$GOV" == "$CURRENT_GOV" ]; then
        MENU_OPTIONS+="$GOV (activo)\n"
        SELECTED_INDEX=$COUNT
    else
        MENU_OPTIONS+="$GOV\n"
    fi
    COUNT=$((COUNT + 1))
done

# 5. Lanzar Rofi
CHOICE=$(echo -e "${MENU_OPTIONS%\\n}" | rofi -dmenu -i -theme "$general_style" \
    -p "CPU: ${AVG_FREQ}MHz | Modo:" \
    -selected-row "$SELECTED_INDEX")

# Limpiar la elección (quitar el "(activo)" si se seleccionó ese)
CHOICE_CLEAN=$(echo "$CHOICE" | awk '{print $1}')

# 6. Aplicar cambio
if [ -n "$CHOICE_CLEAN" ]; then
    # Solo ejecutar si es un cambio real
    if [ "$CHOICE_CLEAN" != "$CURRENT_GOV" ]; then
        sudo cpupower frequency-set -g "$CHOICE_CLEAN" && \
        notify-send "CPU Power" "Cambiado a: $CHOICE_CLEAN" --icon=processor
    else
        notify-send "CPU Power" "Ya estás en modo $CHOICE_CLEAN" --icon=processor
    fi
fi
