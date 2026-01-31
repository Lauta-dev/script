#!/bin/bash

PKG_LIST="$HOME/dev/script/a"

# Definimos los colores ANSI
C_AUR='\033[33m'   # Amarillo
C_REPO='\033[32m'  # Verde
C_RESET='\033[0m'

# Comando para colorear: si empieza por aur/ usa amarillo, si no, verde
COLOR_CMD="awk -F/ '{ if (\$1 == \"aur\") print \"$C_AUR\"\$1\"$C_RESET/\"\$2; else print \"$C_REPO\"\$1\"$C_RESET/\"\$2 }'"

cat $PKG_LIST | eval "$COLOR_CMD" |  fzf --ansi --header "C-X: AUR | C-V: Oficiales | C-R: Todos" \
  --bind "start:reload(grep -v '^aur/' $PKG_LIST | $COLOR_CMD)" \
  --bind "ctrl-x:reload(grep '^aur/' $PKG_LIST | $COLOR_CMD)" \
  --bind "ctrl-v:reload(grep -v '^aur/' $PKG_LIST | $COLOR_CMD)" \
  --bind "ctrl-r:reload(cat $PKG_LIST | $COLOR_CMD)" \
  --preview 'pkg={}; repo=${pkg%/*}; name=${pkg#*/}; [[ $repo == "aur" ]] && yay -Si $name --color always || pacman -Si $name --color always' \
  --style 'minimal' \
  --preview-window="right:75%" \
  --multi | xargs -ro yay -S --needed
