set -x GOPATH $HOME/dev/go
set -x PATH $PATH $GOPATH/bin $HOME/bin $HOME/.cargo/bin
set -x PATH $PATH $HOME/dev/wine-dirs/build32
set -x XKB_DEFAULT_LAYOUT dk
set -x XKB_DEFAULT_VARIANT nodeadkeys
set -x CCACHE_DIR $HOME/.ccache
set -x PATH /usr/lib/ccache/bin $PATH
