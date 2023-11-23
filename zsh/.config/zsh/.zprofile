#!/bin/bash

if [ -f $HOME/bin/ssh-agent-manager.sh ]
then 
  . $HOME/bin/ssh-agent-manager.ssh 
else
  echo "ssh-agent-manager not found, no ssh keys loaded"
fi 
