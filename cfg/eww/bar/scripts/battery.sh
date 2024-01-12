#!/bin/bash

BASE_PATH="eww/bar"
declare -A charging_icons=(
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

declare -A discharging_icons=(
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

function get_battery() {
	BAT=""
	for battery in /sys/class/power_supply/*; do
		if [[ $battery == *"BAT"* ]]; then
			BAT=$(basename "$battery")
			break
		fi
	done
	echo "$(cat /sys/class/power_supply/"${BAT}"/capacity)%"
}

function get_battery_icon() {
	BAT=""
	for battery in /sys/class/power_supply/*; do
		if [[ $battery == *"BAT"* ]]; then
			BAT=$(basename "$battery")
			break
		fi
	done

	BAT_STATUS=$(cat /sys/class/power_supply/"${BAT}"/status)
	BAT_VAL=$(cat /sys/class/power_supply/"${BAT}"/capacity)
	BAT_VAL_ROUNDED=$($BASE_PATH/scripts/utils.sh --round "$BAT_VAL")
	ICON=${charging_icons[$BAT_VAL_ROUNDED]}
	if [[ $BAT_STATUS == "Discharging" ]]; then
		ICON=${discharging_icons[$BAT_VAL_ROUNDED]}
	fi

	echo "$ICON"
}

function get_battery_status() {
	BAT=""
	for battery in /sys/class/power_supply/*; do
		if [[ $battery == *"BAT"* ]]; then
			BAT=$(basename "$battery")
			break
		fi
	done

	BAT_STATUS=$(cat /sys/class/power_supply/"${BAT}"/status)
	echo "$BAT_STATUS"
}

case $1 in
	--get) get_battery;;
	--get_icon) get_battery_icon;;
	--status) get_battery_status;;
esac