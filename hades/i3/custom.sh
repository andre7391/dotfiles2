#!/bin/bash

########################################
# Function to toggle display using xrandr
#
# Arguments:
#   None
########################################
i3::toggle_display() {
    current=$(xrandr --current)

    xrandr --auto

    if [[ "$current" = *"HDMI-1 connected"* ]]; then
        xrandr --output HDMI-1 --primary --mode 1920x1080 --rate 120.00

        if [[ -f /tmp/toggle_display ]]; then
            xrandr --output eDP-1 --same-as HDMI-1

            rm /tmp/toggle_display
        else
            xrandr --output eDP-1 --left-of HDMI-1
            
            i3-msg "workspace S"
            i3-msg "move workspace to output eDP-1"

            touch /tmp/toggle_display
        fi
    fi
}

########################################
# Function to configure display using xrandr
#
# Arguments:
#   None
########################################
i3::configure_display() {
    rm /tmp/toggle_display
    refresh_display
}

"$@"
