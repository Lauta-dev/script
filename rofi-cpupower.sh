#!/bin/bash

general_style="~/dev/script/rofi-themes/cpupower.rasi"

# 1. Obtener la lista de gobernadores disponibles
# xargs elimina espacios en blanco sobrantes
GOVERNORS_LIST=$(cpupower frequency-info -g | grep "available cpufreq governors" | cut -d ":" -f 2 | xargs)

# 2. Obtener el gobernador activo actualmente
CURRENT_GOV=$(cpupower frequency-info -p | grep "The governor" | awk -F '"' '{print $2}')

# 3. Obtener la frecuencia media actual (para el prompt)
AVG_FREQ=$(grep "cpu MHz" /proc/cpuinfo | head -n 1 | cut -d ":" -f 2 | xargs | cut -d "." -f 1)

# 4. Construir la lista para Rofi y calcular el índice resaltado
MENU_OPTIONS=""
SELECTED_INDEX=0
SELECTED_GOV=""
COUNT=0
LIST_COL=2
LIST_ROW=3

for GOV in $GOVERNORS_LIST; do
    # Si el gobernador es el actual, lo marcamos visualmente (opcional)
    if [ "$GOV" == "$CURRENT_GOV" ]; then
        MENU_OPTIONS+="$GOV\n"
        SELECTED_INDEX=$COUNT
        SELECTED_GOV="$GOV"
    else
        MENU_OPTIONS+="$GOV\n"
    fi
    COUNT=$((COUNT + 1))
done

# 5. Lanzar Rofi
CHOICE=$(echo -e "${MENU_OPTIONS%\\n}" | rofi -dmenu -i \
  -theme-str "listview {columns: $LIST_COL; lines: $LIST_ROW;}" \
  -theme-str 'mainbox{children: [ "message", "listview" ];}' \
  -theme-str "window {width: 565;}" \
  -theme "$general_style" \
  -mesg "CPUPOWER | ${AVG_FREQ}MHz | $SELECTED_GOV" \
  -p "Modo:" \
  -selected-row "$SELECTED_INDEX")

# Limpiar la elección (quitar el "(activo)" si se seleccionó ese)
CHOICE_CLEAN=$(echo "$CHOICE" | awk '{print $1}')

# 6. Aplicar cambio
if [ -n "$CHOICE_CLEAN" ]; then
    if [ "$CHOICE_CLEAN" != "$CURRENT_GOV" ]; then
        # Cambiamos 'sudo' por 'pkexec'
        if pkexec cpupower frequency-set -g "$CHOICE_CLEAN"; then
            notify-send "CPU Power" "Cambiado a: $CHOICE_CLEAN" --icon=processor
        else
            notify-send "CPU Power" "Acción cancelada o error de autenticación" --icon=dialog-error
        fi
    else
        notify-send "CPU Power" "Ya estás en modo $CHOICE_CLEAN" --icon=processor
    fi
fi
