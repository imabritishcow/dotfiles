alias x_in_docker="doas docker run -d -u 1000:1000 --rm -e HOME \
  -e DISPLAY=unix:0 -e XAUTHORITY=/tmp/xauth \
  -v $XAUTHORITY:/tmp/xauth -v $HOME:$HOME \
  -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix -w $HOME"

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function twitch() {
  streamlink --player mpv https://twitch.tv/$1 best
}

function youtube() {
  if [[ $1 == *"youtube.com"* || $1 == *"youtu.be"* ]]; then
      mpv --fs $1 & disown
    elif [[ $1 == *"invidious"* ]]; then
      ytLink=$(echo $1 | sed "s#https:\/\/.*\/#https://youtube.com/#g")
      mpv --fs $ytLink & disown
    else
      yt $@
    fi
}

alias yt="youtube"
alias ttv="twitch"
alias code="codium ."
