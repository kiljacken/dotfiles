#!/bin/bash

function wm() {
    xrdb -load ~/.Xresources &
    xsetroot -name $1

    combton -xb -o0

    dropbox &
    synergy &
    tint2 &

    exec $1
}

[[ -z $1 ]] && wm openbox-session

wm $1
