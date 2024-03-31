#!/usr/bin/env bash

########################################
# Move all workspaces to specified monitor
#
# Arguments:
#   $1 - Destination monitor 
######################################## 
bspwm_move_workspaces() {

    workspaces=(1 2 3 4 5 6 7 8 9)
    
    for workspace in ${workspaces[@]} ; do
        bspc desktop $workspace -m $1
    done
}

########################################
# Run sxhkd with a custom config file
#
# Arguments:
#   None
######################################## 
bspwm_sxhkd() {
    pkill sxhkd
    sxhkd -c ~/.config/bspwm/default-sxhkd.rc ~/.config/bspwm/custom-sxhkd.rc
}

########################################
# Function to toggle display using xrandr
#
# Arguments:
#   None
########################################
bspwm_toggle_display() {

    xrandr --auto

    # hdmi is connected
    external_connected=$([[ "$(xrandr --current)" = *"HDMI-1 connected"* ]] && echo "0")

    # hdmi is destination to toogle
    external_toogle=$([[ -f /tmp/toggle_display ]] && echo "0")

    # hdmi is forced to display
    external_force=$([[ ! -z $1 ]] && echo "0")

    # move placeholder workspaces
    bspc desktop PI -m eDP-1
    bspc desktop PE -m HDMI-1

    # remove default workspace
    bspc desktop Desktop -r 2> /dev/null

    # reset padding
    bspc config top_padding 0
    bspc config bottom_padding 0
    bspc config left_padding 0
    bspc config right_padding 0
    

    if [[ $external_connected && ( $external_toogle || $external_force )  ]] ; then

        # configure external display
        xrandr --output HDMI-1 --primary --mode 1920x1080 --rate 120.00 --pos 1366x0
        xrandr --output eDP-1 --pos 0x312

        # sleep to let monitor startup
        # [[ ! $external_force ]] && sleep 2

        # move workspace S to eDP-1 monitor
        bspc desktop S -m eDP-1
        
        # move remaining workspaces to HDMI-1 monitor
        bspwm_move_workspaces HDMI-1

        # focus to hide placeholders
        bspc desktop -f S
        bspc desktop -f 1

        # bar padding
        bspc config -m eDP-1 top_padding 0
        bspc config -m HDMI-1 top_padding 32

        rm /tmp/toggle_display 2> /dev/null
    else

        # configure internal display
        xrandr --output eDP-1 --primary
        # xrandr --output HDMI-1 --same-as eDP-1

        # sleep to let monitor startup
        # [[ ! $external_force ]] && sleep 2

        # move workspaces to eDP-1 monitor
        bspwm_move_workspaces eDP-1

        # focus to hide placeholders
        bspc desktop -f 1

        # bar padding
        bspc config -m eDP-1 top_padding 32

        touch /tmp/toggle_display
    fi

    eww reload
}


########################################
# Run mouse config
#
# Arguments:
#   None
########################################
bspwm_mouse() {
    ~/.local/bin/mouse.sh
}

########################################
# Run startup programs
#
# Arguments:
#   None
########################################
bspwm_custom_startup() {
    bspwm_sxhkd &
    bspwm_toggle_display true &
    bspwm_mouse &
}

