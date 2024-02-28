#!/usr/bin/env bash

########################################
# Function to configure display using xrandr
#
# Arguments:
#   None
########################################
bspwm_configure_display() {
    current=$(xrandr --current)

    # default padding
    bspc config top_padding 25

    xrandr --auto

    if [[ "$current" = *"DisplayPort-0 connected"* ]]; then
        xrandr --output DisplayPort-0 --primary --mode 1920x1080 --rate 164.97
    fi
}

########################################
# Run startup programs
#
# Arguments:
#   None
########################################
bspwm_custom_startup() {
    bspwm_configure_display &
}
