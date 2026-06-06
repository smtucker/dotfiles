#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

DATA=$(boring l)

ROFI_OPTIONS=$(echo "$DATA" | awk '
    # Match lines starting with [ and ending with ] (the groups)
    /^\[.*\]$/ { 
        current_group = $0 
        next 
    }
    # Skip header lines or empty lines
    /^Status/ || /^$/ { 
        next 
    }
    # Process actual data lines
    { 
        # $1=Status, $2=Name, $3=Local, $4="->", $5=Remote, $6=Via
        if ($1 == "closed") {
          color = "red"
        } else {
          color = "green"
        }
        printf "<span foreground=\"%s\">%10-s | %s | %s %s %s | [%s]</span>\n", color, current_group, $2, $3, $4, $5, $1
    }
')

SELECTION=$(echo "$ROFI_OPTIONS" | rofi -dmenu -i -p "SSH Channels" -window-title "Toggle Channel" -markup-rows -theme "${SCRIPT_DIR}"/boring.rasi)

if [ -z "$SELECTION" ]; then
    echo "No selection made. Exiting."
    exit 0
fi

NAME=$(echo "$SELECTION"  | awk -F '|' '{print $2}' | tr -d ' ')
STATUS=$(echo "$SELECTION" | awk -F '|' '{print $4}' | tr -d ' []' | sed 's/<\/span>//')

if [ "$STATUS" = "closed" ]; then
    if boring open "$NAME"; then
      notify-send -i "/usr/share/icons/Adwaita/symbolic/status/network-transmit-receive-symbolic.svg" "Boring: Channel opened" "Successfully opened channel: $NAME"
    else
      notify-send -i "/usr/share/icons/Adwaita/symbolic/status/network-error-symbolic.svg" "Boring: Channel failed to open" "Error opening channel: $NAME"
    fi
else
    if boring close "$NAME"; then
      notify-send -i "/usr/share/icons/Adwaita/symbolic/status/network-offline-symbolic.svg" "Boring: Channel closed" "Successfully closed channel: $NAME"
    else
      notify-send -i"/usr/share/icons/Adwaita/symbolic/status/network-error-symbolic.svg" "Boring: Channel failed to close" "Error closing channel: $NAME"
    fi
fi
