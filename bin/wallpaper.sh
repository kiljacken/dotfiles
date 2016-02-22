#!/bin/sh
WALLPAPER="$HOME/Dropbox/wallpapers/monogatari-color/"
TIME="5m"
while true; do
	find $WALLPAPER -type f \( -name '*.jpg' -o -name '*.png' \) -print0 |
		shuf -n1 -z | xargs -0 feh --bg-scale
	sleep $TIME
done
