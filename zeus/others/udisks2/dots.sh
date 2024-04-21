#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# udev rules
copy_to_root $dir/udisks2.rules /etc/udev/rules.d/99-udisks2.rules

# mount rules
copy_to_root $dir/media.conf /etc/tmpfiles.d/media.conf