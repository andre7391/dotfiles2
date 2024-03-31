#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# custom configs
symlink $dir/.profile ~/.profile
