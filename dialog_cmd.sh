#!/bin/bash
# Created: by Alex Aleyan
# Note: a more efficient way to capture the user's input is to load it into a VAR instead of redirecting to a file.

which dialog
if [[ $? -ne 0 ]]; then
    echo "MAKE SURE DIALOG IS INSTALLED!!!"
    exit -1 
fi

exit_on_signal_SIGINT () {
echo "Exiting with status 4; SIGINT"
exit 4;
}

exit_on_signal_SIGTERM () {
echo "Exiting with status 5; SIGTERM"
exit 4;
}

#trap exit_on_signal_SIGINT SIGINT;
#trap exit_on_signal_SIGTERM SIGTERM;

#offsets the block from left upper conner
dialog \
--title "TITLE HERE" \
--backtitle 'BACKTITLE HERE' \
--begin 3 10 \
--cancel-label "CANCEL LABLE OVERRIDE" \
--extra-button --extra-label "EXTR BTTN" \
--clear \
--calendar 'TEXT COMES HERE' 5 80 11 01 1987

dialog \
--checklist "CHECK LIST" 20 30 30 \
tag1 item1 status1 \
tag2 item2 status2 \
tag3 item3 status3 \
2>file.txt

#DIRECTORY SELECT:
dialog \
--title "DIR SELECT HERE" \
--dselect ./ 20 30 2>dsel.txt

#FILE SELECT
dialog \
--title "FILE SELECT HERE" \
--fselect $HOME/ 20 30 2>fsel.txt \

#TEXT EDITTING:
dialog \
--editbox "$PWD/editbox.txt" 20 20 2>editbox.txt

#FORM 
#dialog \
#--form "FORM TEXT" 30 30 15 label1 1 1 item1 1 1 flen1 ilen1 \
#--form "FORM TEXT" 30 30 15 label2 1 1 item1 1 1 flen1 ilen1

#GAUGE:
dialog \
--title "GAUGE WITH A CANCEL BUTTON" \
--extra-button --extra-label "CANCEL" \
--gauge "IT'S A GAUGE" 10 20 99

#infobox
dialog --infobox "INFOBOX" 10 40

#inputbox
dialog --inputbox "INPUT BOX" 10 40 2>>editbox.txt

dialog --inputmenu "INPUTMENU BOX" 30 30 20 tag1 item1 2>>editbox.txt

dialog --menu "MENU BOX" 30 30 20 tag1 item1 2>>editbox.txt

dialog --mixedform "MIXED BOX" 30 30 20 label1 ly1 lx1 item1 iy1 ix1 flen ilen1 itype 2>>editbox.txt

dialog --mixedgauge "MIXEDGAUGE BOX" 30 30 20 tag1 item1 tag2 item2

dialog --msgbox "MSGBOX BOX" 30 30

dialog --passwordbox "PASSWORDBOX BOX" 30 30

dialog --passwordform "PASSWORDFORM BOX" 30 30 20 label1 ly1 lx1 item1 iy1 ix1 flen ilen1

dialog --pause "PAUSE BOX" 30 30 2

dialog --progressbox 30 30


CHOICE_FILE=radiolist.txt
DIMENSIONS="22 27 30"
SHMNG_IP=192.168.412.72

dialog --radiolist \
"RADIOLIST BOX" \
$DIMENSIONS \
1 item1 status1 \
2 item2 status2 2>$CHOICE_FILE

#if [[ $? == 1 ]]
#then
#break
#fi
#CHOICE=($(cat $CHOICE_FILE))
#echo "$CHOICE"
#/usr/bin/expect <<EOD
#spawn ssh -oStrictHostKeyChecking=no -oCheckHostIp=no root@${SHMNG_IP}
#expect "root@${SHMNG_IP}'s password:" { send "\n" }
#expect "# " { send "clia setfanlevel all $CHOICE\n\n"}
#expect "# " { send "ls\n" }
#interfact
#EOD

touch "tailbox.txt"
echo "Hello Tailbox" > tailbox.txt
dialog --tailbox tailbox.txt 30 30

#touch "tailboxbg.txt"
#echo "Hello tailboxbg" > tailboxbg.txt
#dialog --tailboxbg tailboxbg.txt 30 30

touch "textbox.txt"
echo "Hello textbox" > textbox.txt
dialog --textbox textbox.txt 30 30

dialog --timebox "timebox box" 30 30 15 30 25

dialog --yesno "yesno box" 30 30 2>>editbox.txt


choice=($(cat file.txt))

#dialog \


for i in ${choice[@]}
do
		echo "$i"
done

cat dsel.txt
echo ""
cat fsel.txt
echo ""
cat editbox.txt
echo ""

rm *.txt
