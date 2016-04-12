#!/bin/bash

function wm() {
    xrdb -load ~/.Xresources &
    xsetroot -name $1 &

    nvidia-persistenced &
    mpd ~/config/mpd/mpd.conf &

    dropbox &
    synergy &
    tint2 &

    feh --bg-scale ~/wallpaper.jpg

    exec $1
}

[[ -z $1 ]] && wm openbox-session

wm $1
