# Setup colors
$HOME/bin/base16-default.dark.sh

# Customize prompt
COLOR_NAME_HOST="32m"
COLOR_DIR="34m"
PS1="\[\033[$COLOR_NAME_HOST\]\u@\h \[\033[$COLOR_DIR\]\w \\$\[\033[0m\] "
