#/bin/bash

skip_confirm=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-confirm)
      skip_confirm=1
      shift
      ;;
    --help)
          cat <<EOF
rm-tui – Interfaz TUI para borrar archivos y directorios usando fzf
------------------------------------------------------------------

Uso:
  rmtui [opciones]

Opciones disponibles:

  --no-confirm
      Ejecuta el borrado sin pedir confirmación.
      Útil para automatizar o cuando ya revisaste los elementos seleccionados.

  --help, -h
      Muestra este mensaje de ayuda y termina.

Descripción:
  Este script abre una interfaz interactiva basada en fzf donde podés seleccionar
  archivos y directorios para borrar. Los elementos se clasifican en archivos,
  directorios y otros, mostrándolos antes de confirmar la acción.

Ejemplos:
  rmtui
      Abre la interfaz y pregunta confirmación antes de borrar.

  rmtui --no-confirm
      Borra directamente lo seleccionado sin pedir confirmación.

EOF
    exit 0
      ;;
        *)
        echo "Argumento desconocido: $1"
        exit 1
      ;;
  esac
done


mapfile -d '' files < <(
      {
    # Directorios visibles
    find . -maxdepth 1 -mindepth 1 -type d ! -name ".*" -print0
    # Archivos visibles
    find . -maxdepth 1 -mindepth 1 -type f ! -name ".*" -print0

    # Directorios ocultos
    find . -maxdepth 1 -mindepth 1 -type d -name ".*" -print0
    # Archivos ocultos
    find . -maxdepth 1 -mindepth 1 -type f -name ".*" -print0
  } |
 fzf -m --style minimal --preview-window=right:80% --read0 --print0 --multi \
  --preview "/bin/bash if [ -d "{}" ]; then tree -C "{}" | head -200; else /bin/bat "{}"; fi"
)

[ -z "$files" ] && exit 0

files_arr=()
dirs_arr=()
other_arr=()

for f in "${files[@]}"; do
  if [ -d "$f" ]; then
    dirs_arr+=("$f")

  elif [ -f "$f" ]; then
    files_arr+=("$f")

  else
    other_arr+=("$f")
  fi
done

if [ "$skip_confirm" = 0 ]; then
  echo "Los siguientes elementos se borraran:"

  echo " "

  echo "Archivos:"
  printf ' - %s\n' "${files_arr[@]}"

  echo " "

  echo "Directorios:"
  printf ' - %s\n' "${dirs_arr[@]}"

  echo " "

  echo "Otros:"
  printf ' - %s\n' "${other_arr[@]}"

  echo " "

  read -p "¿Continuar? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
fi

echo " "

count=${#files[@]}
current=0

for f in "${files[@]}"; do
  current=$((current + 1))
  printf "\rEliminando %d/%d: %s" "$current" "$count" "$f"
  rm -fr -- "$f"
done

echo

