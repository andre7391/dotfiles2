#!/bin/bash

########################################
# Function to configure display using xrandr
#
# Arguments:
#   None
########################################
i3::configure_display() {
    current=$(xrandr --current)

    xrandr --auto

    if [[ "$current" = *"DisplayPort-0 connected"* ]]; then
        xrandr --output DisplayPort-0 --primary --mode 1920x1080 --rate 164.97
    fi
}

"$@"
