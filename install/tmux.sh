#!/bin/bash

# Check for existing folders to make sure we make them before stowing
# If the symbolic links are there we will download to dotfiles

if ! ./pkgmng.sh tmux; then
  exit 1
fi

git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
echo "Press C-a+I to launch the plugin manager" 
