#!/bin/bash

FILE="$HOME/.local/bin/ssh-agent-manager"

if [ -e "$FILE" ]
then 
  . $FILE
else
  echo "ssh-agent-manager not found, no ssh keys loaded"
fi 
