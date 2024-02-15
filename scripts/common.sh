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

    # verify if has changes in fonts
    if [[ $(diff -qr fonts/ /usr/share/fonts/common/ | grep -v uuid) ]] ; then
        sudo rm -rf /usr/share/fonts/common
        sudo mkdir -p /usr/share/fonts/common
        sudo cp -r fonts/* /usr/share/fonts/common
        sudo chown -R root:root /usr/share/fonts/common
        sudo fc-cache -f -v >> /dev/null
        echo "fonts successfully installed at: [/usr/share/fonts/common]"
        
    else
        echo "fonts already installed at: [/usr/share/fonts/common]"
    fi

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
    common.symlink kitty/kitty.conf ~/.config/kitty/kitty.conf
    common.symlink eww ~/.config/eww
    common.symlink wallpapers ~/.config/wallpapers
    common.symlink dunst/dunstrc ~/.config/dunst/dunstrc
    common.symlink xinit/.xinitrc ~/.xinitrc
    common.symlink flavours ~/.config/flavours


    common.symlink themes ~/.themes
    common.symlink themes/gtk2 ~/.gtkrc-2.0
    common.symlink themes/gtk3 ~/.config/gtk-3.0/settings.ini
    common.symlink themes/xsettings ~/.config/xsettingsd/xsettingsd.conf

    echo -e ":: finished common symlinks\n"

}

common::copy_to_root() {
    
    # udisks2 config
    if ! [ -f $2 ] && ! [ -d $2 ] ; then
        sudo cp -r $1 $2
        sudo chown -R root:root $2
        echo "file copied from: [$1] to [$2]"
    else
        echo "file already exists: [$2]"
    fi
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