#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
if is_arch ; then 
    arch_install zsh
    arch_install starship
else
    is_installed zsh
    is_installed starship
fi

# symlink
symlink $dir/starship.toml ~/.config/starship.toml
