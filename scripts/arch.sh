#!/bin/bash


# imports
source $(dirname "$0")/common.sh



########################################
# Install package using yay package manager in arch
#
# Arguments:
#   $1 - Command to execute the program / app
#   $2 - Package name at arch/aur repository
########################################
arch.install () {

    # check if its already installed
    if ! common.installed $1 ; then

        # install the package
        if ! [ -z "$2" ]; then 
            yay -S --needed --noconfirm $2 > /dev/null
        else 
            yay -S --needed --noconfirm $1 > /dev/null
        fi

        echo "installed successfully: [$1]"
    else
        echo "already installed: [$1]"
    fi
}



########################################
# Install package eww in arch
#
# Arguments:
#   None
########################################
arch.install.eww () {


    # if ! installed eww ; then
    #     install=T
    # else
    
    #     installed-version=$(eww --version | cut -d ' ' -f2)
    #     last-version=$(git ls-remote --sort=committerdate https://github.com/elkowar/eww refs/tags/* | cut -f2 | tail -1)
        
    #     if [[ $last-version =~ "*" ]]; then echo "string contains asterisk"; fi
    # fi


    # check if eww is installed
    if ! common.installed eww ; then

        # install dependencies
        yay -S --needed --noconfirm gtk3 pango gdk-pixbuf2 cairo glib2 gcc-libs glibc > /dev/null
        
        # checkout eww repository
        rm -rf /tmp/eww-install
        git clone https://github.com/elkowar/eww /tmp/eww-install

        (
            # build eww
            cd /tmp/eww-install
            cargo build --release --no-default-features --features x11 
            chmod +x target/release/eww
            
            # install eww in /usr/bin
            sudo chown root:root target/release/eww
            sudo cp target/release/eww /usr/bin
        )

        echo "installed successfully: [eww]"
    else
        echo "already installed: [eww]"
    fi
}



########################################
# Function to install all common packages used in arch
#
# Arguments:
#   None
########################################
arch.install.packages() {

    echo -e "\n:: starting common packages arch"

    # install arch packages
    arch.install xrandr xorg-xrandr
    arch.install picom
    arch.install dmenu
    arch.install dunst
    arch.install nitrogen
    arch.install alacritty
    arch.install thunar
    arch.install rofi
    arch.install feh
    arch.install unzip

    # isntall eww
    arch.install.eww

    echo -e ":: finished common packages arch\n"
}