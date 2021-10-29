#!/bin/bash
#
# Syntax: color.sh
# Author: Arnau Carrasco <arnau.carrasco@gmail.com>
#
# This script prints on stdout all terminal color code combinations
#

for attr in 0 1 4 5 7 ; do
    for fore in 30 31 32 33 34 35 36 37; do
        for back in 40 41 42 43 44 45 46 47; do
            printf '\033[%s;%s;%sm%s;%s;%02s\033[0m ' $attr $fore $back $attr $fore $back
        done
    printf '\n'
    done
    printf '\033[0;0m'
done

