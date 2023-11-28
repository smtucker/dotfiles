#!/bin/bash
# Check to see if the given command is installed
# and install it if it is not.
#
# First argument is the command to look for and
# the second argument is the package name

CMD=$1
PKG=${2:-$CMD}

install_pkg () {
  if command -v pacman > /dev/null 2>&1; then
    echo "sudo pacman -S $1"
  fi 
  if command -v apt-get > /dev/null 2>&1; then
    echo "sudo apt-get install $1"
  fi 
}

if ! command -v "$CMD" > /dev/null 2>&1; then
  echo "'$PKG' not installed. Installing..."
  install_pkg $PKG
  if ! command -v "$CMD" > /dev/null 2>&1; then
    echo "'$PKG' install failed. Exiting."
    exit 1
  fi
else
  echo "$PKG already installed, continuing..."
fi

exit 0
