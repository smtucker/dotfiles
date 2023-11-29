#!/bin/bash

git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

echo "default_linemode devicons" >> $HOME/.config/ranger/rc.config

git clone https://github.com/joouha/ranger_tmux
