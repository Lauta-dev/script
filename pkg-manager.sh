#!/bin/env bash

if ! command -v fzf &>/dev/null; then
    echo "Error: fzf no está instalado. Instálalo con: sudo pacman -S fzf"
    exit 1
fi

packages=$(pacman -Slq | fzf -e --preview 'pacman -Sii {}' --style minimal --preview-window="right:75%" --multi)

if [[ -z "$packages" ]]; then
    echo "No se seleccionó ningún paquete."
    exit 0
fi

echo "Paquetes seleccionados:"
echo "$packages"

read -rp "¿Quieres instalarlos? [s/N]: " confirm
if [[ "$confirm" =~ ^[sS]$ ]]; then
    sudo pacman -S --needed $packages
else
    echo "Instalación cancelada."
fi
