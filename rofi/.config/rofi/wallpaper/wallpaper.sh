#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme='style-1'

## Select wallpaper
cd ~/Pictures/wallpapers || return 1
P=$(for a in *; do echo -en "$a\0icon\x1f$a\n"; done |
rofi \
    -dmenu \
    -theme "${dir}"/"${theme}".rasi)

## Quit if P is empty
if [ -z "$P" ]; then 
  exit
fi

notify-send "Changing wallpaper" "Changing to $P"

wal --cols16 lighten -i ~/Pictures/wallpapers/"$P"

cp ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors.css
cp ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/shared/colors.rasi
cp ~/.cache/wal/yazi-theme.toml ~/.config/yazi/theme.toml
cp ~/.cache/wal/colors.Xresources ~/.Xresources

pkill waybar
hyprctl dispatch exec "waybar"

pkill swaybg
hyprctl dispatch exec "swaybg -i ~/Pictures/wallpapers/$P"

xrdb -merge ~/.Xresources
oomox-cli /opt/oomox/scripted_colors/xresources/xresources-reverse

/opt/oomox/plugins/icons_gnomecolors/gnome-colors-icon-theme/change_color.sh -o oomox-xresources-reverse /opt/oomox/scripted_colors/xresources/xresources-reverse
