#!/bin/bash

MODE=$(cat ~/.cache/current_mode 2>/dev/null || echo "dark")

if [[ "$MODE" == "light" ]]; then
    export MODE="dark"
else
    export MODE="light"
fi

echo "$MODE" > ~/.cache/current_mode

. ~/dev/script/gen_colors_based_on_wallpaper.sh $(grep -oP "'.*?'" ~/.fehbg | tr -d "'")
