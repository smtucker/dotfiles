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
. "$HOME/.cargo/env"
