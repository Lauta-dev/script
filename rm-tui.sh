#/bin/bash

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
  --preview "if [ -d "{}" ]; then tree -C "{}" | head -200; else /bin/bat "{}"; fi"
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

for f in "${files[@]}"; do
  rm -frv -- ${f}
done
