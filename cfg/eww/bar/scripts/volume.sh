#!/bin/bash

BASE_PATH="eww/bar"
declare -A volume_icons=(
	[100]="100"
	[90]="90"
	[80]="80"
	[70]="70"
	[60]="60"
	[50]="50"
	[40]="40"
	[30]="30"
	[20]="20"
	[10]="10"
	[0]="0"
)

function get_volume() {
	VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]*%' | sed 's/%//' | head -n 1)
	echo "$VOLUME"
}

function get_volume_icon() {
	VOLUME=$(get_volume)
	VOLUME_ROUNDED=$($BASE_PATH/scripts/utils.sh --round "$VOLUME")
	echo "${volume_icons[$VOLUME_ROUNDED]}"
}

function set_volume() {
    pactl set-sink-volume @DEFAULT_SINK@ "$1"%
}

function toggle_volume() {
    pactl set-sink-mute @DEFAULT_SINK@ toggle
}

case $1 in
	--get) get_volume;;
	--get-icon) get_volume_icon;;
	--set) set_volume "$2";;
	--toggle) toggle_volume;;
esac