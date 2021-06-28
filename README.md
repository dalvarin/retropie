# My Retropie Stuff <!-- omit in toc -->

- [1. Scripts](#1-scripts)
  - [1.1. Parada de Emulation Station](#11-parada-de-emulation-station)
  - [1.2. Arranque de Emulation Station](#12-arranque-de-emulation-station)
- [2. Procedimientos](#2-procedimientos)
  - [2.1. Alta de juegos en DOSbox](#21-alta-de-juegos-en-dosbox)
    - [2.1.1. **Preparación general de Emulation Station**](#211-preparación-general-de-emulation-station)
    - [2.1.2. **Preparación de los directorios del juego**](#212-preparación-de-los-directorios-del-juego)
    - [2.1.3. **Instalación del juego**](#213-instalación-del-juego)
    - [2.1.4. **Mapeo de botones y sticks**](#214-mapeo-de-botones-y-sticks)
      - [**Mapeo de botones y sticks con el keymapper de DOSbox**](#mapeo-de-botones-y-sticks-con-el-keymapper-de-dosbox)

## 1. Scripts

### 1.1. Parada de Emulation Station

### 1.2. Arranque de Emulation Station

## 2. Procedimientos

### 2.1. Alta de juegos en DOSbox

#### 2.1.1. **Preparación general de Emulation Station**

- Juego empleado para el ejemplo: Alone In The Dark 2
- Lo primero, si no se ha hecho antes, es configurar en Emulation Station la sección del MSDOS/Dosbox/PC para que sólo reconozca como ejecutables los ficheros .sh (así ya no saldrán los .bat, .exe, .com, etc y podemos controlar mejor la ejecución y dejarlo todo más limpio).
  - Hacer backup del fichero actual y sustituir el fichero por uno nuevo.

```sh
cp -p /opt/retropie/configs/all/emulationstation/es_systems.cfg /opt/retropie/configs/all/emulationstation/es_systems.cfg_<YYYYMMDD>
cp -p /etc/emulationstation/es_systems.cfg /opt/retropie/configs/all/emulationstation
```

- Configurar la sección de pc.

```xml
<system>
    <name>pc</name>
    <fullname>PC</fullname>
    <path>/home/pi/RetroPie/roms/pc</path>
    <extension>.sh .SH</extension>
    <command>/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ pc %ROM%</command>
    <platform>pc</platform>
    <theme>pc</theme>
</system>
```

#### 2.1.2. **Preparación de los directorios del juego**

- Crear el directorio del juego en /home/pi/RetroPie/roms/pc/games. Lo Creamos en mayúsculas y con menos de 8 caracteres (modo MS-DOS!!)

```sh
/home/pi/RetroPie/roms/pc/games/AITD2
```

- Creamos tantos directorios de unidad como sean necesarios:

```sh
/home/pi/RetroPie/roms/pc/games/AITD2/C # Para montar la unidad donde realizaremos la instalación del juego.
/home/pi/RetroPie/roms/pc/games/AITD2/CD # Para montar la unidad de CD para aquellos juegos donde sea necesario.
```

#### 2.1.3. **Instalación del juego**

En esta sección puede haber muchas variaciones, desde una instalación que sólo sea descomprimir y jugar hasta una instalación a nivel de MSDOS.

- Instalación de autoextraible *.EXE
  - Es el caso del AITD2
  - Creamos el directorio donde descomprimir el juego
    ``/home/pi/RetroPie/roms/pc/games/AITD2/C/AITD2``
  - Copiamos el autoextraible ahí (ALONE2.EXE).
  - TBC: falta el procedimiento de crear un fichero temporal de dosbox para entrar en una sesión de la herramienta y ejecutar el .EXE.

#### 2.1.4. **Mapeo de botones y sticks**

Hay dos herramientas para mapear los botones y sticks de la consola:

- CASO 1: El keymapper del dosbox: se usa para juegos controlados por teclado y en los que el joystick funciona como debe.
- CASO 2: [Linux Joystick Mapper](https://sourceforge.net/p/linuxjoymap/wiki/Home/) que se utiliza en juegos donde sea necesario el ratón o el joystick no funcione como debe.

##### **Mapeo de botones y sticks con el keymapper de DOSbox**

Mapeamos las teclas necesarias para el juego con los botones de la consola:




