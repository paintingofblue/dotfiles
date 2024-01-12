#!/bin/bash

STATUS="$(playerctl status)"

function get_status() {
	if [ "$STATUS" = "Playing" ];
    then
		echo ""
	else
		echo ""
	fi
}

function get_song() {
  	song="$(playerctl metadata xesam:title)"
	if [[ -z "$song" ]];
    then
		echo "Offline"
	else
		echo "$song"
	fi
}

function get_artist() {
	artist="$(playerctl metadata xesam:artist)"
	if [[ -z "$artist" ]];
    then
		echo ""
	else
		echo "$artist"
	fi
}

function get_cover() {
    if [ "$STATUS" = "Playing" ] || [ "$STATUS" == "Paused" ];
    then
        playerctl metadata mpris:artUrl
    else
        echo "img/music"
    fi
}

function toggle() {
    playerctl play-pause
}

function next() {
    playerctl next
}

function previous() {
	playerctl previous
}

case $1 in
	--song) get_song;;
	--artist) get_artist;;
	--status) get_status;;
	--cover) get_cover;;
	--toggle) toggle;;
	--next) next;;
	--prev) previous;;
esac