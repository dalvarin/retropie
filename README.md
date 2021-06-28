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
      - [**Mapeo de botones y sticks con Linux Joystick Mapper**](#mapeo-de-botones-y-sticks-con-linux-joystick-mapper)

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

- Manual del juego. En este caso: [https://www.freegameempire.com/games/Alone-in-The-Dark-2/manual](https://www.freegameempire.com/games/Alone-in-The-Dark-2/manual)
- En el fichero~/.dosbox/dosbox-SVN.conf este parámetro debe estar así: joysticktype=fcs (para poder mapear el pad con las flechas de movimientos).
- Nos aseguramos de que el mapa por defecto está limpio:

```bash
pi@retropie:~/RetroPie/roms/pc/AITD2 $ cd ~/.dosbox/
pi@retropie:~/.dosbox $ ls
dosbox-SVN.conf  emulators.cfg  mapper-SVN.map
pi@retropie:~/.dosbox $ mv mapper-SVN.map mapper-SVN.old
```

- Lanzamos el mapper (preferiblemente desde un terminal remoto con X windows…en la propia consola es un poco infernal hacer esto).

```bash
pi@retropie:/opt/retropie/emulators/dosbox/bin/dosbox -startmapper
```

- Se abrirá el keymapper:
![images/dosbox_keymapper_001.png](images/dosbox_keymapper_001.png)

- La parte marcada en azul es lo que se activa con el joystick=fcs
- Ahora no tenemos más que ir seleccionando teclas con el ratón, darle a "Add" y pulsar el botón adecuado.
- "Save" y "Exit" al finalizar.
- Escribimos exit para salir del dosbox
- Copiamos el fichero de mapeo al directorio /home/pi/RetroPie/roms/pc/games/AITD2 y lo llamamos dosbox.map

```bash
cp ~/.dosbox/mapper-SVN.map  /home/pi/RetroPie/roms/pc/games/AITD2/dosbox.map
```

##### **Mapeo de botones y sticks con Linux Joystick Mapper**

- Descargar: [Linux Joystick Mapper](https://sourceforge.net/p/linuxjoymap/wiki/Home/)
- Descomprimir y compilar. En el paquete también viene un txt con las teclas posibles y unos cuantos pdfs y ejemplos de uso.

```bash
/home/pi/utils/joymap-0.4.2
make
```

- Comprobamos el estado de los dispositivos de entrada de la consola.

<pre>pi@retropie:~/utils/joymap-0.4.2 $ cat /proc/bus/input/devices
I: Bus=0003 <b>Vendor=2341 Product=8036</b> Version=0101
N: <b>Name="Arduino LLC Arduino Leonardo"</b>
P: Phys=usb-3f980000.usb-1.3/input2
S: Sysfs=/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.2/0003:2341:8036.0001/input/input0
U: Uniq=HIDAF
H: <b>Handlers=js0</b> event0
B: PROP=0
B: EV=1b
B: KEY=ffff 0 0 0 0 0 0 0 0 0 0 0 0 ffff 0 0 0 0 0 0 0 0 0
B: ABS=f003f
B: MSC=10
 
I: Bus=0003 Vendor=046d Product=400e Version=0111
N: Name="Logitech K400"
P: Phys=usb-3f980000.usb-1.4:1
S: Sysfs=/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.4/1-1.4:1.2/0003:046D:C52B.0004/0003:046D:400E.0005/input/input1
U: Uniq=400e-30-07-d3-fb
H: Handlers=sysrq kbd leds mouse0 event1
B: PROP=0
B: EV=12001f
B: KEY=3007f 0 0 0 0 483ffff 17aff32d bf544446 0 0 ffff0001 130f93 8b17c007 ffff7bfa d9415fff febeffdf ffefffff ffffffff fffffffe
B: REL=1c3
B: ABS=1 0
B: MSC=10
B: LED=1f
 
I: Bus=0003 Vendor=0001 Product=0001 Version=0001
N: Name="circuitsword"
P: Phys=
S: Sysfs=/devices/virtual/input/input2
U: Uniq=
H: Handlers=sysrq kbd event2
B: PROP=0
B: EV=3
B: KEY=ffff ffefffff ffffffff fffffffe</pre>

- Estos son los dispositivos que aparecen sin nada conectado a la consola:

<pre>pi@retropie:/dev/input $ ll
total 0
drwxr-xr-x  2 root root      80 abr 20 21:24 by-id
drwxr-xr-x  2 root root      80 abr 20 21:24 by-path
crw-rw----+ 1 root input 13, 64 abr 20 21:22 event0
crw-rw----  1 root input 13, 65 abr 20 21:22 event1
<b>crw-rw----+ 1 root input 13,  0 abr 20 21:22 js0</b>
crw-rw----  1 root input 13, 63 abr 20 21:22 mice
pi@retropie:/dev/input $</pre>

