set -x GOPATH $HOME/Sync/dev/go

set -x CCACHE_DIR $HOME/.ccache

set -x XKB_DEFAULT_LAYOUT dk
set -x XKB_DEFAULT_VARIANT nodeadkeys

function append_path
  if test -d $argv
    set -x PATH $PATH $argv
  end
end

function prepend_path
  if test -d $argv
    set -x PATH $argv $PATH
  end
end

append_path $GOPATH/bin
append_path $HOME/bin
append_path $HOME/.cargo/bin
append_path $HOME/dev/wine-dirs/build32

prepend_path /usr/lib/ccache/bin

set -x FS_LEX_YACC_LIBS /home/kiljacken/lib/FsLexYacc.Runtime.7.0.6/lib/portable-net45+netcore45+wpa81+wp8+MonoAndroid10+MonoTouch10/
