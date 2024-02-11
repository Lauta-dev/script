#!/bin/bash

# Este script lanza una notificación cuando se cambie/pare/reprodusca una canción usando MPD (lo de CMUS te lo debo)
# Dependecias: mpd, mpc, notify-send, dunst

music_player=$1
action=$2

icon_path="/usr/share/icons/Tela-circle-blue-dark/24/actions"

icon_next="$icon_path/media-seek-backward.svg"
icon_prev="$icon_path/media-seek-forward.svg"

icon_play="$icon_path/media-playback-start.svg"
icon_pause="$icon_path/media-playback-pause.svg"


dunst() {
  # $1 (cabecera), $2 (descripción), $3 (icono)
  dunstify -u low -r 1 -a "$1" "$2" -i "$3"
}

# TODO: Hacer lo que falta de CMUS
function cmus() {
  local cmus_state="$(cmus-remote -Q | grep "status"| cut -d " " -f2)"

  function selected_music (){
    echo "as"
  }

  function toogle (){
    echo "asd"
  }
}

function mpd() {
   function selected_music (){
     $(mpc $action)

     local artist_name="$(mpc -f %artist% current)"
     local music_name="$(mpc -f %title% current)"
     local music_duration="$(mpc -f %time% current)"
     local music_file="$(mpc -f %file% current)"

     # Si no se encuentra el titulo de la canción, muestra el nombre del fichero
     local music_name_format=$(if [[ $music_name == '' ]]; then echo $music_file; else echo $music_name; fi)

     # Si no se encuentra el artista de la canción muestra "No encontrado"
     local artist_name_format=$(if [[ $artist_name == '' ]]; then echo "No encontrado"; else echo "$artist_name"; fi)

     # Iconos para saber si esta en reprodución
     local icons=$(if [[ $action == 'next'  ]]; then echo $icon_prev; else echo $icon_next; fi)

     $(dunst "$artist_name_format :: $music_duration" "$music_name_format" "$icons")
  }

  function toogle () {
    local status="$(mpc status | grep -o '\[.*\]')"

    local artist_name="$(mpc -f %artist% current)"
    local music_name="$(mpc -f %title% current)"
    local music_duration="$(mpc -f %time% current)"
    local music_file="$(mpc -f %file% current)"

    # Si no se encuentra el titulo de la canción, muestra el nombre del fichero
    local music_name_format=$(if [[ $music_name == '' ]]; then echo $music_file; else echo $music_name; fi)

    # Si no se encuentra el artista de la canción muestra "No encontrado"
    local artist_name_format=$(if [[ $artist_name == '' ]]; then echo "No encontrado"; else echo "$artist_name"; fi)

    $(mpc toggle)

    case "$status" in
      '[playing]') dunst "$artist_name_format :: $music_duration" "$music_name_format" "$icon_pause"
      ;;
      '[paused]') dunst "$artist_name_format :: $music_duration" "$music_name_format" "$icon_play"
      ;;
      *) echo default
      ;;
    esac
  }

  case "$action" in
    'toggle') toogle
    ;;
    'next' | 'prev') selected_music
    ;;
    *) notify-send "Message" "Este comando es desconocido"
    ;;
  esac
}

case "$music_player" in
  "mpd") mpd
  ;;
  "cmus") cmus
  ;;
  *) notify-send "Message" "UwU"
  ;;
esac

