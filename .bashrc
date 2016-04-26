# Setup colors
$HOME/bin/base16-default.dark.sh

# Customize prompt
COLOR_NAME_HOST="32m"
COLOR_DIR="34m"
PS1="\[\033[$COLOR_NAME_HOST\]\u@\h \[\033[$COLOR_DIR\]\w \\$\[\033[0m\] "

export PATH=$PATH:$HOME/bin
export STEAM_FRAME_FORCE_CLOSE=1

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

