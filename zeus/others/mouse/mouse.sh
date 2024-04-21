#!/usr/bin/env bash

export DISPLAY=:0
export XAUTHORITY=/home/andre.rodrigues/.Xauthority

(
sleep 0.5
xinput set-prop 'G603 Mouse' 'libinput Accel Profile Enabled' 0 1
) & disown