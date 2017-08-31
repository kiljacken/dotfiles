#!/bin/bash

function wm() {
    xrdb -load ~/.Xresources &
    xsetroot -name $1 &

    #nvidia-persistenced &
    #mpd ~/config/mpd/mpd.conf &

    #compton -cb -o0 &

    #feh --bg-scale ~/wallpaper.png

    nm-applet &
    dropbox &
    syncthing-gtk &

    exec $1
}

#startxfce4

[[ -z $1 ]] && wm i3

wm $1
