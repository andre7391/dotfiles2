#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
if [[ $(is_arch) ]] ; then 
    arch_install wal pywal
else
    is_installed wal
fi

# wallpapers
symlink $dir/templates ~/.config/wal/templates

