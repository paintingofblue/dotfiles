#!/bin/bash

# each format uses the strftime convention, with a + added to the start
# the + is optional because the get_time function adds it for you,
# but it's preferred to add it yourself lol
# https://devhints.io/strftime
declare -A time_fmts=(
    ["time"]="+%H:%M:%S"
    ["date"]="+%d/%m/%Y"
    ["dateverbose"]="+%a %d %b"
)

function get_time() {
    local format="$1"

    # add a + to the start of format if it isnt there
    # this is needed for the date command to work properly
    if [[ ! "$format" =~ ^\+ ]]; then
        format="+$format"
    fi

	date "$format"
}

# default to time format if no argument is given
fmt_arg="$1"
if [[ -z "$fmt_arg" ]]; then
    fmt_arg="time"
fi

fmt="${time_fmts[$fmt_arg]}"
get_time "$fmt"