#!/bin/bash

# Directorio donde están tus versiones
VERSIONS_DIR="$HOME/Games/minecraft/games"
THEME="$HOME/dev/script/rofi-themes/minecraft-launcher.rasi"

# Listar carpetas en el directorio de versiones y pasarlas a Rofi
SELECTED_VERSION=$(ls "$VERSIONS_DIR" | rofi -dmenu \
  -p "Seleccionar Versión de Minecraft:" \
  -mesg "Ejecutar Minecraft Bedrock" \
  -theme "$THEME"
)

# Si el usuario seleccionó algo, lanzamos el cliente
if [ -n "$SELECTED_VERSION" ]; then
    notify-send "Lanzando $SELECTED_VERSION..."
    GAME="$VERSIONS_DIR/$SELECTED_VERSION"
    SYSLIBMC="/home/lautaro/Games/minecraft/mcpelauncher/sys_libs"
    
    # Aquí el comando que ya te funciona
    LD_LIBRARY_PATH="$SYSLIBMC:$GAME/lib/native/x86_64:$GAME/lib/x86_64:$LD_LIBRARY_PATH" \
      /home/lautaro/Games/minecraft/mcpelauncher/mcpelauncher-client \
      -dg "$GAME" \
      -dd "$GAME"
fi
