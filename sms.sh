#!/bin/bash
NC='\033[0m'
RED='\033[1;38;5;196m'
GREEN='\033[1;38;5;040m'
ORANGE='\033[1;38;5;202m'
BLUE='\033[1;38;5;012m'
BLUE2='\033[1;38;5;032m'
PINK='\033[1;38;5;013m'
GRAY='\033[1;38;5;004m'
NEW='\033[1;38;5;154m'
YELLOW='\033[1;38;5;214m'
CG='\033[1;38;5;087m'
CP='\033[1;38;5;221m'
CPO='\033[1;38;5;205m'
CN='\033[1;38;5;247m'
CNC='\033[1;38;5;051m'

function banner(){
echo -e ${YELLOW}" ╔═╗╔╦╗╔═╗  ╔═╗╔═╗╔═╗╔═╗╔═╗ "
echo -e ${YELLOW}" ╚═╗║║║╚═╗  ╚═╗╠═╝║ ║║ ║╠╣  "
echo -e ${YELLOW}" ╚═╝╩ ╩╚═╝  ╚═╝╩  ╚═╝╚═╝╚   \n"
   
}
resize -s 38 70 > /dev/null
function dependencies(){
echo -e ${NC}
cat /etc/issue.net


echo " Vérification des fichiers de téléchargements... " 
sleep 1
if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" != "" ]]; then
  echo ${NC}"Vous n'étes pas connecter a internet."
  exit 1
  else
  echo -e ${NC} "\n[ ✔ ] Internet"
fi
sleep 1
which curl > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e ${NC} "\n[ ✔ ] Curl"
else
echo -e $red "[ X ] curl  -> ${RED}N'est pas Installer."
echo -e ${YELLOW} "[ ! ] Installation de Curl..."
sudo apt-get install curl
echo -e ${GREEN} "[ ✔ ] Installation Terminer."
fi
sleep 1
which git > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e ${NC} "\n[ ✔ ] Git"
else
echo -e $red "[ X ] git  -> ${RED}N'est pas Installer."
echo -e ${RED} "[ ! ] Installation de Git..."
pkg update && pkg upgrade  > /dev/null 2>&1
pkg install git > /dev/null 2>&1
echo -e ${GREEN} "[ ✔ ] Installation Terminer."
which git > /dev/null 2>&1
sleep 1
fi
sleep 1
}

function SENDSMS() {
    clear
    banner
   echo -e ${YELLOW}"${YELLOW}[${NC}Utilisation${YELLOW}] : ${GREEN}Mettre le numero de la victime."
   echo -e ${YELLOW}"${YELLOW}[${NC}Exemple${YELLOW}]     : ${GREEN}+33691823716\n"
   echo -e -n ${YELLOW}"${YELLOW}[${NC}Numero${YELLOW}] :${NC} "
   
   read num
   
   echo -e -n ${YELLOW}"${YELLOW}[${NC}Message${YELLOW}] :${NC} "
   
   read msg


   SMSVERIFY=$(curl -# -X POST https://textbelt.com/text --data-urlencode phone="$num" --data-urlencode message="$msg" -d key=textbelt)
   
   if grep -q true <<<"$SMSVERIFY"
   
   then
      
      echo "  "
      echo -e ${GREEN}" MESSAGE ENVOYER AVEC SUCCESS ! "
      echo "  "
      printmsg
   else
      
      echo "  "
      echo -e ${RED}" MESSAGE PAS ENVOYER ! "
      echo "  "
      printmsg
   fi
}

menu(){

clear
dependencies
clear
banner

echo -e "${YELLOW}[${NC}"1"${YELLOW}]${YELLOW} - ${NC}ENVOYER MESSAGES"
echo -n -e ${YELLOW}"\n${YELLOW}[${NC}+${YELLOW}] ${NC}NOMBRE ${YELLOW}:${NC} "
read play
   if [ $play -eq 1 ]; then
          SENDSMS
          exit
         
      fi
}
menu
