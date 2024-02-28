#!/usr/bin/env bash

########################################
# Run eww
#
# Arguments:
#   None
########################################
bspwm_eww() {
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
bspwm_picom() {
    pkill picom
    sleep 0.2
    picom --daemon --config ~/.config/picom/picom.conf 
}

########################################
# Run pywal
#
# Arguments:
#   None
######################################## 
bspwm_pywal() {
    wal -steq -R
}

########################################
# Run sxhkd
#
# Arguments:
#   None
######################################## 
bspwm_sxhkd() {
    pkill sxhkd
    sxhkd -c ~/.config/bspwm/default-sxhkd.rc
}

########################################
# Run startup programs
#
# Arguments:
#   None
########################################
bspwm_default_startup() {
    bspwm_sxhkd &
    bspwm_eww &
    bspwm_picom &
    bspwm_pywal &
}

