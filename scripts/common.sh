#!/bin/bash


########################################
# Verify if a package / app is installed
#
# Arguments:
#   $1 - Command to execute the program / app
########################################
common.installed() {
    [ -x "$(command -v $1)" ]    
}



########################################
# Helper to symlink files e make automatic backups
#
# Arguments:
#   $1 - File or folder to be symlinked
#   $2 - Destiny where the synlink will be created
########################################
common.symlink() {

    # check if file/folder already exists to make a backup
    if ([ -f $2 ] || [ -d $2 ]) && ! [ -L $2 ]; then
        mv $2 "$1-backup"
    fi

    # create destiny folder
    if ! [ -e $2 ] && ! [ -L $2 ]; then
        mkdir -p $2
    fi

    # remove file/folder and create symlink
    rm -r $2
    ln -s $(realpath -s $1) $2
    
    echo "symlink created from: [$1] to [$2]"
}



########################################
# Function to install fonts in the system
#
# Arguments:
#   None
########################################
common.install.fonts() {

    echo -e "\n:: starting common fonts"

    sudo mkdir -p /usr/share/fonts/common
    sudo cp -r fonts/* /usr/share/fonts/common
    sudo chown -R root:root /usr/share/fonts/common
    sudo fc-cache -f -v >> /dev/null

    echo -e ":: finished common fonts\n"

}


########################################
# Function to symlink all common configs at user home
#
# Arguments:
#   None
########################################
common.symlink.home() {

    echo -e "\n:: starting symlink home"

    common.symlink i3/config ~/.config/i3/config
    common.symlink picom/picom.conf ~/.config/picom/picom.conf
    common.symlink alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
    common.symlink eww ~/.config/eww
    common.symlink wallpapers ~/.config/wallpapers
    common.symlink dunst/dunstrc ~/.config/dunst/dunstrc
    common.symlink xinit/.xinitrc ~/.xinitrc

    echo -e ":: finished common symlinks\n"

}