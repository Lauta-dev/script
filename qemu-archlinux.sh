#!/bin/bash

# Qemu -> https://wiki.archlinux.org/title/QEMU_(Espa%C3%B1ol)

# -m = Memoria
# -smp = Hilos del procesador
# -name = Nombre que tenga la VM
# -boot = no se
# -hda = Disco duro virtual
# -cdrom = Ruta de la imagen ISO

qemu-system-x86_64 -m 1G \
  -smp 1 \
  --enable-kvm \
  -name "Debian netinst" \
  -boot d \
  -cdrom ~/Documentos/cd_rom/archlinux-2024.03.01-x86_64.iso
