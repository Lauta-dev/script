#!/bin/bash
personal_terminal="alacritty"
terminal="alacritty"
browser_web='zen'
file_manager="thunar $HOME"
music="$terminal --title cmus --command cmus"
htop="$terminal -t htop -e htop"
notes='obsidian'
terminal_file_manager="$terminal -t ranger -e ranger"

code_editor() {
  NVIM_APPNAME=lauta_dev_nvim alacritty -T NeoVim -e nvim -c "Telescope persisted"
}

case "$1" in
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
  'ce') code_editor
  ;;
	'notes') $notes
	;;
  'tf') $terminal_file_manager
  ;;
esac

