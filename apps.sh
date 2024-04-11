#!/bin/bash
# Scripts para lanzar aplicaciones

arg=$1

personal_terminal='st -t Terminal'
terminal='st'
browser_web='thorium-browser'
file_manager='pcmanfm'
music="$terminal -t mpd -e ncmpcpp"
htop="$terminal -t htop -e htop"
code_editor='codium'
note_edito='~/.app/obsidian.AppImage'
terminal_file_manager="$terminal -t ranger -e ranger"

case "$arg" in
  'terminal') $personal_terminal
  ;;
  'browser') $browser_web
  ;;
  'fm') $file_manager
  ;;
  'music') $music
  ;;
  'htop') $htop
  ;;
  'code_editor') $code_editor
  ;;
	'node_editor') $node_editor
	;;
  'tf') $terminal_file_manager
  ;;
esac

