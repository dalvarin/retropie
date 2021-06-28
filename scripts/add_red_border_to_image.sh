#!/bin/sh
# Script chorra que usa el ImageMagik para añadir un borde rojo a las caratulas
# Solo para jpg
# Sólo para un archivo a la vez

if [ $# -ne 1 ]
then
  echo "Please, add one argument <pc_game_id>"
  echo "  Example: METALMUT"
  exit 1
fi

if [ ! -f ~/RetroPie/roms/pc/games/${1}/${1}.jpg ]
then
  echo "Image ~/RetroPie/roms/pc/games/${1}/${1}.jpg does not exist. Aborting image modification"
  exit 1
fi

timestamp=$(date +%s)

mv ~/RetroPie/roms/pc/games/${1}/${1}.jpg ~/RetroPie/roms/pc/games/${1}/${1}.jpg.${timestamp}

convert ~/RetroPie/roms/pc/games/${1}/${1}.jpg.${timestamp} -bordercolor Red -border 5x5 ~/RetroPie/roms/pc/games/${1}/${1}.jpg
