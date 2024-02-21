#!/bin/bash

source $(dirname ${BASH_SOURCE})/utils.sh

########################################
# Function to install fonts at user home
#
# Arguments:
#   None
########################################
shared::symlink_fonts() {

    echo -e "\n:: starting shared fonts"

    mkdir -p ~/.local/share/fonts/shared
    new=$(find ~/.local/share/fonts/shared | sort | md5sum)

    touch ~/.local/share/fonts/md5sum
    old=$(<~/.local/share/fonts/md5sum)

    # compare md5sum to check if the fonts changed
    if [[ $old != $new ]] ; then 
        
        sudo rm -rf /usr/share/fonts/common
        utils::symlink shared/fonts ~/.local/share/fonts/shared
        sudo fc-cache -f -v >> /dev/null
        printf "%s" "$new" > ~/.local/share/fonts/md5sum

        echo "fonts successfully installed at: [$HOME/.local/share/fonts]"
        
    else
        echo "fonts already installed at: [$HOME/.local/share/fonts]"
    fi

    echo -e ":: finished common fonts\n"
}

########################################
# Function to symlink all shared configs at user home
#
# Arguments:
#   None
########################################
shared::symlink_home() {

    echo -e "\n:: starting symlink home"

    # i3wm
    utils::symlink shared/i3/default.conf ~/.config/i3/config
    utils::symlink shared/i3/default.conf ~/.config/i3/default.conf
    utils::symlink shared/i3/default.sh ~/.config/i3//default.sh

    # picom
    utils::symlink shared/picom/default.conf ~/.config/picom/picom.conf

    # kitty
    utils::symlink shared/kitty/default.conf ~/.config/kitty/kitty.conf

    # eww
    utils::symlink shared/eww/default.yuck ~/.config/eww/eww.yuck
    utils::symlink shared/eww/default.scss ~/.config/eww/eww.scss
    utils::symlink shared/eww/default.yuck ~/.config/eww/default.yuck
    utils::symlink shared/eww/default.scss ~/.config/eww/default.scss
    utils::symlink shared/eww/scripts ~/.config/eww/scripts





    utils::symlink shared/wallpapers ~/.config/wallpapers
    
    # xinit
    utils::symlink shared/xinit/.xinitrc ~/.xinitrc

    utils::symlink shared/flavours ~/.config/flavours
    
    utils::symlink config/.profile ~/.profile


    utils::symlink shared/themes ~/.themes
    utils::symlink shared/themes/gtk2 ~/.gtkrc-2.0
    utils::symlink shared/themes/gtk3 ~/.config/gtk-3.0/settings.ini
    utils::symlink shared/themes/xsettings ~/.config/xsettingsd/xsettingsd.conf

    echo -e ":: finished common symlinks\n"

}

########################################
# Function to configure udisks2 and mounting point
#
# Arguments:
#   None
########################################
common::udisks2() {

    echo -e "\n:: starting udisks2 config"

    common::copy_to_root udisks2/99-udisks2.rules /etc/udev/rules.d/99-udisks2.rules
    #common::copy_to_root udisks2/media.conf /etc/tmpfiles.d/media.conf

    echo -e ":: finished udisks2 configs\n"
}
