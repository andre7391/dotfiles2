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
    sleep 0.1
    xdo below -t $(xdo id -n root) $(xdo id -n eww)
}

########################################
# Run picom
#
# Arguments:
#   None
########################################
bspwm_picom() {
    pkill picom
    sleep 0.1
    picom --daemon --config ~/.config/picom/picom.conf 
}

########################################
# Run pywal
#
# Arguments:
#   None
######################################## 
bspwm_pywal() {
    # update theme
    wal --saturate 0.7 -ste --iterative -a 80 -i ~/.config/wallpapers
}

########################################
# Change pywal theme based on wallpaper
#
# Arguments:
#   None
######################################## 
bspwm_change_theme() {

    wallpaper=$(shuf -e -n1 ~/.config/wallpapers/*)

    feh --bg-fill $wallpaper
    wallust run -s $wallpaper
    eww reload
    xdo below -t $(xdo id -n root) $(xdo id -n eww)


    # # update theme
    # wal --saturate 0.7 -ste --iterative -a 80 -i ~/.config/wallpapers

    # reload bspwm colors
    . ~/.cache/wallust/colors-bash.sh
    bspc config normal_border_color "$color1"
    bspc config active_border_color "$color2"
    bspc config focused_border_color "$color15"
    bspc config presel_feedback_color "$color1"

    # xsettingsd to reload gtk
    pkill xsettingsd
    xsettingsd &
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
    bspwm_change_theme &
}

