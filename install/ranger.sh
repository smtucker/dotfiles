#!/bin/bash

rfolder="$HOME/.config/ranger"
tplug="$rfolder/plugins"

if ! [ -d "$tplug/ranger_devicons" ]; then
  git clone https://github.com/alexanderjeurissen/ranger_devicons $tplug/ranger_devicons
  echo "default_linemode devicons" >> $rfolder/rc.config
fi

if ! [ -d "$rfolder/plugins/zoxide" ]; then
  echo "Installing zoxide plugin for ranger"
  git clone git@github.com:jchook/ranger-zoxide.git ~/.config/ranger/plugins/zoxide
fi
#if ! [ -d "$tplug/ranger_tmux" ]; then
#  git clone https://github.com/joouha/ranger_tmux $tplug/ranger_tmux
#fi
