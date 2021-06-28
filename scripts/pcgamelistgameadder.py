import xml.etree.ElementTree as ET
from xml.dom import minidom
import shutil
import datetime
import sys

original_filename="gamelist.xml"
file_path="/opt/retropie/configs/all/emulationstation/gamelists/pc/"
bkpsufix = datetime.datetime.now().strftime("_%Y%m%d%H%M%S")

print('Configuring /opt/retropie/configs/all/emulationstation/gamelists/pc/gamelist.xml')
print('######################')
print('Game alias: ' + str(sys.argv[1]))
print('Game name: ' + str(sys.argv[2]))

answer=input('is that correct?(Y/[N])')

if answer != 'Y' and answer != 'y':
  quit()

print('Backup File: ' + file_path + "bkp/" + original_filename + bkpsufix )
shutil.copyfile(file_path + original_filename, file_path + "bkp/" + original_filename + bkpsufix)

tree=ET.parse(file_path + original_filename)
root=tree.getroot()

newgame=ET.SubElement(root,'game')
newpath=ET.SubElement(newgame,'path')
newpath.text='./' + str(sys.argv[1]) + '.sh'
newname=ET.SubElement(newgame,'name')
newname.text=str(sys.argv[2])
newimage=ET.SubElement(newgame,'image')
newimage.text='./games/' + str(sys.argv[1]) + '/' + str(sys.argv[1]) + '.jpg'

rough_string = ET.tostring(root, 'utf-8')
reparsed = minidom.parseString(rough_string)

lines = reparsed.toprettyxml(indent="  ").split("\n")
non_empty_lines = [line for line in lines if line.strip() != ""]

string_without_empty_lines = ""
for line in non_empty_lines:
  string_without_empty_lines += line + "\n"

print(string_without_empty_lines)

text_file = open(file_path + original_filename, "w")
text_file.write(string_without_empty_lines)
text_file.close()

print("Gamelist content")
print("################")
print(string_without_empty_lines)
print("########################################################")
print("Don't forget to add ~/.emulationstation/downloaded_images/pc/" + str(sys.argv[1]) + ".jpg file")
