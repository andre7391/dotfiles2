#!/bin/bash

########################################
# Run eww
#
# Arguments:
#   None
########################################
bspwm::eww() {
    pkill eww
    eww daemon &> /dev/null
    eww open bar-window &> /dev/null
}

########################################
# Run picom
#
# Arguments:
#   None
########################################
bspwm::picom() {
    pkill picom
    sleep 0.5
    picom --daemon --config ~/.config/picom/picom.conf 
}

########################################
# Run feh
#
# Arguments:
#   None
######################################## 
bspwm::feh() {
    feh --bg-fill $(shuf -e -n1 ~/.config/wallpapers/*)
}

########################################
# Run sxhkd
#
# Arguments:
#   None
######################################## 
bspwm::sxhkd() {
    pkill sxhkd
    sxhkd -c ~/.config/bspwm/sxhkdrc
}

########################################
# Run startup programs
#
# Arguments:
#   None
########################################
bspwm::start() {
    bspwm::sxhkd &
    bspwm::eww &
    bspwm::picom &
    bspwm::feh &
}

"$@"
