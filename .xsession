#!/usr/bin/zsh

# debug
echo $PATH > $HOME/xlog.log
echo $GOPATH >> $HOME/xlog.log

# wallpaper
$HOME/bin/wallpaper.sh &
feh --randomize --bg-scale $HOME/Dropbox/wallpapers/monogatari-color/

# load xresources
xrdb ~/.Xresources

# launch urxvt daemon
urxvtd -q -o -f

# setup i3 terminal
export TERMINAL=$(which urxvtc)

# launch i3
exec dbus-launch --sh-syntax --exit-with-session i3
