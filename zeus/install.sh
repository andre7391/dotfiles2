#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# parent directory
parent=$(dirname $dir)

# imports
. $parent/shared/scripts/utils.sh
. $parent/shared/scripts/arch.sh


banner "Common modules"
dots shared/alacritty
dots shared/kitty
dots shared/picom
dots shared/bspwm
dots shared/eww
dots shared/rofi
dots shared/lf
dots shared/others


banner "Appearance and theming"
dots shared/appearance


banner "Zeus"
dots zeus
