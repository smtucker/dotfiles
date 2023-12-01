#!/bin/bash

export ZDOTDIR="${ZDOTDIR:-"$HOME/.config/zsh"}"
export ZSH="$ZDOTDIR/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin/:$GOPATH/bin:$PATH"
