#!/bin/bash
if ! command -v zsh > /dev/null 2>&1;
then
  echo "Zsh not found. Installing..."
  if command -v pacman > /dev/null 2>&1;
  then
    echo "Found pacman..."
    sudo pacman -S zsh
  fi 
  if command -v apt > /dev/null 2>&1;
  then
    echo "Found apt..."
    sudo apt install zsh
  fi 
fi 

if ! [ -e ~/.oh-my-zsh/oh-my-zsh.sh ];
then 
    echo "Oh-my-zsh not found. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi 

if ! command -v starship > /dev/null 2>&1;
then
  echo "Starship not found. Installing..."
  curl -sS https://starship.rs/install.sh | sh
fi 
