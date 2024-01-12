#!/bin/bash

# Round number to the nearest 10
function round_number() {
	remainder=$(($1 % 10)) # Number mod 10
	base_number=$(($1 / 10 * 10)) # Number divided by 10, rounded down

	# If remainder is 5 or higher
	if [ "$remainder" -ge 5 ]; then
		# Round up
		echo $((base_number + 10))
	else
		# Round down
		echo $base_number
	fi
}

case $1 in
	--round) round_number "$2";;
esac