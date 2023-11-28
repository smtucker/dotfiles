#!/bin/bash

if ! ./pkgmng.sh zsh; then
  exit 1
fi 

# Load our custom env variables first to make sure directory structure is right
source $HOME/dotfiles/zsh/.zshenv
#$ZSH should now be set to oh-my-zsh
if [ -z "$ZSH" ]; then
  echo "ZSH environment variable not set. Please check .zshenv"
fi

if ! [ -r $ZSH/oh-my-zsh.sh ];
then 
  echo "Oh-my-zsh not found. Installing..."
  if [ -L "$ZSH" ] && [ -d "$ZSH" ]; then
    echo "Oh-my-zsh is not installed but zsh dotfiels are stowed. Unstow and restart."
    exit 1
  fi
  echo "Oh-my-zsh not installed, installing..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi 

if ! command -v starship > /dev/null 2>&1; then
  echo "Starship not found. Installing..."
  curl -sS https://starship.rs/install.sh | sh
fi 

echo "Checking for plugins..."
if ! [ -d "$ZSH/custom/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH/custom/plugins/zsh-autosuggestions"
else
  echo "zsh-autosuggestions already installed"
fi 

if ! [ -d "$ZSH/custom/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH/custom/plugins/zsh-syntax-highlighting"
else
  echo "zsh-syntax-highlighting already installed"
fi 


