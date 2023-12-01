#!/bin/bash

# Lua
sudo luarocks install luacheck

# Golang
go install github.com/mgechev/revive@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/josharian/impl@latest
