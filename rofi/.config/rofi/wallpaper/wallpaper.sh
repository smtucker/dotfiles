#!/usr/bin/env bash

## Configuration
THEMENAME="oomox-xresources-reverse"
BASE16CLI="/opt/oomox/plugins/base16/cli.py"
OOMOXPLUGINDIR="/opt/oomox/plugins/"
QT_STYLE_TEMPLATE="$OOMOXPLUGINDIR/base16/templates/qt-oomox-styleplugin/templates/default.mustache"
GTK4_TEMPLATE="$OOMOXPLUGINDIR/base16/templates/gtk4-oodwaita/templates/gtk4-libadwaita1.6.0.mustache"
TEMPLATE="$OOMOXPLUGINDIR/import_xresources/colors/xresources-reverse"
# TEMPLATE=/opt/oomox/plugins/base16/schemes/pywal/pywal.yml
QT_STYLE_THEMES="$HOME/.config/oomox-qtstyleplugin/themes"
OOMOXCOLOR=/opt/oomox/scripted_colors/xresources/xresources-reverse
dir="$HOME/.config/rofi"
theme='style-1'

## Select wallpaper with rofi
cd ~/Pictures/wallpapers || return 1
P=$(for a in *; do echo -en "$a\0icon\x1f$a\n"; done |
rofi \
    -dmenu \
    -theme "${dir}"/"${theme}".rasi)

## Quit if P is empty
if [ -z "$P" ]; then 
  exit
fi

NID=$(notify-send -p "Changing wallpaper" "Generating colors...")

GENERATE_COLORS() {
  wal --cols16 lighten -i ~/Pictures/wallpapers/"$P"

  cp ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors.css
  cp ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/shared/colors.rasi
  cp ~/.cache/wal/yazi-theme.toml ~/.config/yazi/theme.toml
  cp ~/.cache/wal/colors.Xresources ~/.Xresources
}

RELOAD_APPS(){
  notify-send -r "$NID" "Changing Wallpaper" "Reloading apps..."

  pkill waybar
  hyprctl dispatch exec "waybar"

  pkill swaybg
  hyprctl dispatch exec "swaybg -i ~/Pictures/wallpapers/$P"
}

GENERATE_GTK_THEMES(){
  notify-send -r "$NID" "Changing Wallpaper" "Generating Gtk2/3 themes..."
  xrdb -merge ~/.Xresources
  oomox-cli /opt/oomox/scripted_colors/xresources/xresources-reverse
  notify-send -r "$NID" "Changing Wallpaper" "Generating Gtk4 theme..."
  python "${BASE16CLI}" "${GTK4_TEMPLATE}" "${TEMPLATE}" > "$HOME/.themes/$THEMENAME/gtk-4.0/gtk.css"
  sed -i '/^Import Colors/d' "$HOME/.themes/$THEMENAME/gtk-4.0/gtk.css"
  cp "$HOME/.themes/$THEMENAME/gtk-4.0/gtk.css" "$HOME/.config/gtk-4.0/gtk.css"
}

GENERATE_QT_STYLE() {
  notify-send -r "$NID" "Changing Wallpaper" "Generating Qt themes..."
  if [ -d "${QT_STYLE_THEMES}" ]; then
    cp ~/.cache/wal/oomox-base16.yml "$TEMPLATE"
    python "${BASE16CLI}" "${QT_STYLE_TEMPLATE}" "${TEMPLATE}" > "${QT_STYLE_THEMES}"/oomox.css
    sed -i '/^Import Colors/d' "${QT_STYLE_THEMES}"/oomox.css
  else
    notify-send --icon=error --urgency=critical "Error outputing Qt Stylesheet" "${QT_STYLE_THEMES} does not exist"
  fi
}

GENERATE_ICONS() {
  notify-send -r "$NID" "Changing Wallpaper" "Generating icon theme..."
  /opt/oomox/plugins/icons_gnomecolors/gnome-colors-icon-theme/change_color.sh -o "${THEMENAME}" "${OOMOXCOLOR}"
}

GENERATE_COLORS
RELOAD_APPS
GENERATE_GTK_THEMES
GENERATE_QT_STYLE
GENERATE_ICONS

notify-send -r "$NID" "Wallpaper Changed" "Finishing switching wallpaper to $P"
