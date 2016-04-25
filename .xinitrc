#!/bin/bash

function wm() {
    xrdb -load ~/.Xresources &
    xsetroot -name $1 &

    nvidia-persistenced &
    mpd ~/config/mpd/mpd.conf &

    dropbox &
    compton -cb -o0 &

    feh --bg-scale ~/wallpaper.png

    exec $1
}

[[ -z $1 ]] && wm i3

wm $1
