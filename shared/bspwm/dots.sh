#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if packages are installed
if [[ is_arch ]] ; then 
    arch_install bspwm
    arch_install bspc
    arch_install sxhkd
else
    is_installed bspwm
    is_installed bspc
    is_installed sxhkd
fi

# symlink
symlink $dir/default-bspwm.rc ~/.config/bspwm/bspwmrc
symlink $dir/default-bspwm.rc ~/.config/bspwm/default-bspwm.rc
symlink $dir/default-sxhkd.rc ~/.config/bspwm/default-sxhkd.rc
symlink $dir/default-scripts.sh ~/.config/bspwm/default-scripts.sh
symlink $dir/default-xinit.rc ~/.xinitrc


