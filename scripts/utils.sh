#!/bin/bash


########################################
# Verify if a package / app is installed
#
# Arguments:
#   $1 - Command to execute the program / app
########################################
utils::is_installed() {
    [ -x "$(command -v $1)" ]    
}



########################################
# Helper to symlink files e make automatic backups
#
# Arguments:
#   $1 - File or folder to be symlinked
#   $2 - Destiny where the synlink will be created
########################################
utils::symlink() {

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
# Copy a file to a root owned folder and change file ownership
#
# Arguments:
#   $1 - File or folder to be symlinked
#   $2 - Destiny where the synlink will be created
########################################
utils::copy_to_root() {
    
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

    # i3wm
    common.symlink shared/i3/default.conf ~/.config/i3/config
    common.symlink shared/i3/default.conf ~/.config/i3/default.conf
    common.symlink shared/i3/default.sh ~/.config/i3//default.sh

    # picom
    common.symlink shared/picom/default.conf ~/.config/picom/picom.conf

    # kitty
    common.symlink shared/kitty/default.conf ~/.config/kitty/kitty.conf

    # eww
    common.symlink shared/eww ~/.config/eww


    common.symlink shared/wallpapers ~/.config/wallpapers
    
    # xinit
    common.symlink shared/xinit/.xinitrc ~/.xinitrc

    common.symlink shared/flavours ~/.config/flavours
    
    common.symlink config/.profile ~/.profile


    common.symlink shared/themes ~/.themes
    common.symlink shared/themes/gtk2 ~/.gtkrc-2.0
    common.symlink shared/themes/gtk3 ~/.config/gtk-3.0/settings.ini
    common.symlink shared/themes/xsettings ~/.config/xsettingsd/xsettingsd.conf

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
