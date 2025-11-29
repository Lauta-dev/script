#!/bin/bash

# Array asosiativo
declare -A filetype

CURRENT_DIR="$(pwd)"
ITEMS="$(ls $CURRENT_DIR)"

for item in $ITEMS; do
  if [ -d "$item" ]; then
    continue
  fi

  case "${item##*.}" in
    "sh")
      echo $item 
      ;;
  esac

done

