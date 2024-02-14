#!/bin/bash

source $(dirname "$0")/arch.sh
source $(dirname "$0")/common.sh


# helper to setup hades config
hades() {

    # shared configs
    symlink-common

    # i3
    symlink hades/i3/custom ~/.config/i3/custom
    symlink hades/i3/scripts ~/.config/i3/scripts
}

# helper to setup hades config
zeus() {

    common::udisks2

    # ip link set wlan0 up
    # install-fonts
    common.install.fonts

    # common packages
    arch.install.packages

    # common symlinks
    common.symlink.home

    # i3
    common.symlink i3/zeus/custom ~/.config/i3/custom
    common.symlink i3/zeus/scripts ~/.config/i3/scripts
}

# execute a function passsed as argument (ex: setup shared_symlink)
"$@"



# # i3
# symlink i3/config ~/.config/i3/config

# # picom
# symlink picom/picom.conf ~/.config/picom/picom.conf

# # alacritty
# symlink alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

# # eww 
# symlink eww ~/.config/eww

# # wallpapers
# #symlink wallpapers  

