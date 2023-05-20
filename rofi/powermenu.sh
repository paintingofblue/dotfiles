#!/bin/bash

lock=" Lock"
logout="󰍃 Logout"
shutdown=" Poweroff"
reboot=" Reboot"

# Add $sleep to selected_option, and uncomment this variable if you need it
# sleep=" Suspend"

# You also need to add these lines to the end block
# elif [ "$selected_option" == "$sleep" ]
# then
#     loginctl suspend

selected_option=$(echo "$lock
$logout
$reboot
$shutdown" | rofi -dmenu -i -p "Powermenu" \
		  -theme "$HOME/.config/rofi/powermenu.rasi")

if [ "$selected_option" == "$lock" ]
then
    betterlockscreen -l
elif [ "$selected_option" == "$logout" ]
then
    # loginctl terminate-user `whoami`
    bspc quit
elif [ "$selected_option" == "$shutdown" ]
then
    loginctl poweroff
elif [ "$selected_option" == "$reboot" ]
then
    loginctl reboot
else
    echo "No match"
fi
