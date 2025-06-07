#!/bin/bash

export EDITOR="nvim"
export VISUAL="$EDITOR"
export ZDOTDIR="${ZDOTDIR:-"$HOME/.config/zsh"}"
export ZSH="$ZDOTDIR/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
export GOPATH="$HOME/go"
export BUNPATH="$HOME/.bun/bin"
export PATH="$HOME/.local/bin/:$GOPATH/bin:$BUNPATH:/usr/local/go/bin:$PATH"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# . "$HOME/.cargo/env"
export OOMOX_QTSTYLEPLUGIN_THEME=oomox

source ~/.apikeys/gemini
