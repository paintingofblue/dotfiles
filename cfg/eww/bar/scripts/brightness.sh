#!/bin/bash

# Brightness
function get_brightness() {
	brightnessctl get
}

function set_brightness() {
	brightnessctl set "$1"
}

case $1 in
	--get) get_brightness;;
	--set) set_brightness "$2";;
esac