#!/bin/bash
personal_terminal="alacritty"
terminal="alacritty"
browser_web='brave'
file_manager="thunar $HOME"
music="$terminal --title cmus --command cmus"
htop="$terminal -t htop -e htop"
code_editor='$terminal -t neovim  -e v'
note_edito='~/.app/obsidian.AppImage'
terminal_file_manager="$terminal -t ranger -e ranger"

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
  'code_editor') $code_editor
  ;;
	'node_editor') $node_editor
	;;
  'tf') $terminal_file_manager
  ;;
esac

