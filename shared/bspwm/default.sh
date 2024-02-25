#!/bin/bash

########################################
# Create bspwm workspaces only when necessary
#
# Arguments:
#   None
########################################
bspwm::create_workspaces() {

    # workspaces
    workspaces=(1 2 3 4 5 6 7 8 9 S PI PE)

    # current workspaces
    current_workspaces=($(bspc query -D --names))
    for workspace in ${workspaces[@]} ; do
        if [[ ! ${current_workspaces[@]} =~ $workspace ]] ; then
            bspc monitor -d ${workspaces[@]}
            return 0
        fi
    done
}


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
    wal -steq --iterative -i ~/.config/wallpapers
#    feh --bg-fill $(shuf -e -n1 ~/.config/wallpapers/*)
}

########################################
# Run sxhkd
#
# Arguments:
#   None
######################################## 
bspwm::sxhkd() {
    pkill sxhkd
    sxhkd -c ~/.config/bspwm/default-sxhkd.rc
}

########################################
# Run startup programs
#
# Arguments:
#   None
########################################
bspwm::start() {
    bspwm::create_workspaces &
    bspwm::sxhkd &
    bspwm::eww &
    bspwm::picom &
    bspwm::feh &
}

"$@"
