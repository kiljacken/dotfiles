set -x CCACHE_DIR $HOME/.ccache
set -x EDITOR vim
set -x GOPATH $HOME/sync/dev/go

set -x PATH $PATH $GOPATH/bin $HOME/bin $HOME/.local/bin $HOME/.cargo/bin

alias wine32 "env WINEPREFIX=$HOME/.wine32 WINEARCH=win32 wine"

if ! status --is-interactive
    exit
end

# Check if an existing ssh-agent exists and re-use it
set GOT_AGENT 0
for FILE in /tmp/ssh-*/agent.*;
  set SOCK_PID (string split "." $FILE)[2]
  set PID (ps -fu$LOGNAME|awk '/ssh-agent/ && ( $2=='$SOCK_PID' || $3=='$SOCK_PID' || $2=='$SOCK_PID' +1 ) {print $2}')
  set SOCK_FILE $FILE

  set -x SSH_AUTH_SOCK $SOCK_FILE
  set -x SSH_AGENT_PID $PID

  ssh-add -l > /dev/null
  if [ $status != 2 ]
    set GOT_AGENT 1
    echo "Found existing agent pid $PID"
    break
  end
end

if [ $GOT_AGENT = 0 ]
  eval (ssh-agent -c)
end

# Load AWS credentials to env
if [ -f ~/.aws/credentials ]
  set -x AWS_ACCESS_KEY_ID (cat ~/.aws/credentials | grep aws_access_key_id | cut -d= -f2 | string trim)
  set -x AWS_SECRET_ACCESS_KEY (cat ~/.aws/credentials | grep aws_secret_access_key | cut -d= -f2 | string trim)
end

# Setup sccache
# set -x SCCACHE_BUCKET limelight-sccache2
# set -x SCCACHE_ENDPOINT s3-eu-west-1.amazonaws.com
# set -x RUSTC_WRAPPER (which sccache)

# Sway specific
set -x _JAVA_AWT_WM_NONREPARENTING 1
if [ (hostname) = "exheater" ]
  set -x WLR_DRM_NO_ATOMIC_GAMMA 1
end
