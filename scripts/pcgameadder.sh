#!/bin/sh

if [ $# -ne 3 ]
then
  echo "Please, add two arguments <Game MSDOS alias> <Game name> <Game executable>"
  echo "  Example: Game MSDOS alias: LEMMING2"
  echo "           Game name: \"Lemmings 2: The Tribes\""
  echo "           Game executable: L2.EXE"
  exit 1
fi

if [ -d ~/RetroPie/roms/pc/games/${1} ]
then
  echo "Game directory alreday exists: ~/RetroPie/roms/pc/games/${1}, aborting game environment creation."
  exit 1
fi

if [ -f ~/RetroPie/roms/pc/${1}.sh ]
then
  echo "Game sh script alreday exists: ~/RetroPie/roms/pc/${1}.sh, aborting game environment creation."
  exit 1
fi

gamelist_registered=$(grep "<path>./${1}.sh</path>" ~/.emulationstation/gamelists/pc/gamelist.xml | wc -l)

if [ ${gamelist_registered} -ne 0 ]
then
  echo "Game already registered in ~/.emulationstation/gamelists/pc/gamelist.xml, ${gamelist_registered} time(s). Please, review."
  exit 1
fi

if [ $(~/utils/ES-generic-shutdown/multi_switch.sh --es-pid) -ne 0 ]
then
  echo "ES is runnig, ES must be closed before add a game, do you want to close ES? (Y/[N])"
  read close_es
  if [ "${close_es}" = "Y" ] || [ "${close_es}" = "y" ]
  then
    ~/utils/ES-generic-shutdown/multi_switch.sh --es-systemd
  else
    echo "Please, close emulationstation before running this script"
    exit 1
  fi
fi

echo "Creating game directory: ~/RetroPie/roms/pc/games/${1}/C/${1}"
mkdir -p ~/RetroPie/roms/pc/games/${1}/C/${1}

echo "Creating game sh script"
cp ~/RetroPie/roms/pc/template/template ~/RetroPie/roms/pc/${1}.sh

echo "Copying dosbox config and mapper files"
cp ~/RetroPie/roms/pc/template/dosbox.conf ~/RetroPie/roms/pc/games/${1}/
cp ~/RetroPie/roms/pc/template/dosbox.map ~/RetroPie/roms/pc/games/${1}/

echo "Configuring dosbox.conf file"
sed -in s/GAMEID/"${1}"/ ~/RetroPie/roms/pc/games/${1}/dosbox.conf
sed -in s/GAMENAME/"${2}"/ ~/RetroPie/roms/pc/games/${1}/dosbox.conf
sed -in s/GAMEEXE/"${3}"/ ~/RetroPie/roms/pc/games/${1}/dosbox.conf
rm -f ~/RetroPie/roms/pc/games/${1}/dosbox.confn

cat ~/RetroPie/roms/pc/games/${1}/dosbox.conf

echo "Does this game need mouse support? (Y/[N])"
read mouse_support
if [ "${mouse_support}" = "Y" ] || [ "${mouse_support}" = "y" ]
then
  echo "Copying controls.map file to add mouse support using built-in joystick"
  cp ~/RetroPie/roms/pc/template/controls.map ~/RetroPie/roms/pc/games/${1}/
  echo "Configuring controls.map file"
  sed -in s/GAMEID/"${1}"/ ~/RetroPie/roms/pc/games/${1}/controls.map
fi

python3 ~/utils/pcgamelistgameadder.py ${1} "${2}"

echo "Now, you can copy your game to  ~/RetroPie/roms/pc/games/${1}/C/${1} directory"

echo "Staring ES..."
sudo systemctl restart autologin@tty1.service
sudo systemctl daemon-reload
exit 0
