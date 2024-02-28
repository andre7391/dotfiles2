#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
if [[ is_arch ]] ; then 
    arch_install alacritty
else
    is_installed alacritty
fi

# symlink configs
symlink $dir/default.toml ~/.config/alacritty/alacritty.toml

