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

THEMENAME="oomox-xresources-reverse"

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

BASE16CLI="/opt/oomox/plugins/base16/cli.py"
QT_STYLE_TEMPLATE="/opt/oomox/plugins/base16/templates/qt-oomox-styleplugin/templates/default.mustache"
# TEMPLATE="/opt/oomox/plugins/import_xresources/colors/xresources-reverse"
TEMPLATE=/opt/oomox/plugins/base16/schemes/pywal/pywal.yml
QT_STYLE_THEMES="$HOME/.config/oomox-qtstyleplugin/themes"

if [ -d "${QT_STYLE_THEMES}" ]; then
  cp ~/.cache/wal/oomox-base16.yml $TEMPLATE
  python ${BASE16CLI} ${QT_STYLE_TEMPLATE} ${TEMPLATE} > "${QT_STYLE_THEMES}"/oomox.css
  sed -i '/^Import Colors/d' "${QT_STYLE_THEMES}"/oomox.css
else
  notify-send --icon=error --urgency=critical "Error outputing Qt Stylesheet" "${QT_STYLE_THEMES} does not exist"
fi

/opt/oomox/plugins/icons_gnomecolors/gnome-colors-icon-theme/change_color.sh -o ${THEMENAME} /opt/oomox/scripted_colors/xresources/xresources-reverse
