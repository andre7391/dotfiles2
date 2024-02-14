#!/bin/bash


########################################
# Function to configure mounting point and udisks2
#
# Arguments:
#   None
########################################
media::udisks2() {

    echo -e "\n:: starting udisks2 config"

    sudo cp udisks2/99-udisks2.rules /etc/udev/rules.d/99-udisks2.rules
    sudo chown root:root /etc/udev/rules.d/99-udisks2.rules
    echo "udisks2 config created at: [/etc/udev/rules.d/99-udisks2.rules]"

    sudo cp udisks2/media.conf /etc/tmpfiles.d/media.conf
    sudo chown root:root /etc/tmpfiles.d/media.conf
    echo "tmpfs config created at: [/etc/tmpfiles.d/media.conf]"

    echo -e ":: finished udisks2 configs\n"
}

"$@"