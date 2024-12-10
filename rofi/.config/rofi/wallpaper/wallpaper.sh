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

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function CRIT_ERROR() {
  echo "ERROR: $1"
  if [ -n "$NID" ]; then
    notify-send -a "Wallpaper Switcher" "ERROR: $1" --urgency=critical
  else
    notify-send -a "Wallpaper Switcher" -r "$NID" "ERROR: $1" --urgency=critical
  fi
  return 1
}

## Select wallpaper with rofi
cd ~/Pictures/wallpapers || CRIT_ERROR "Cannot find wallpaper directory"
P=$(for a in *; do echo -en "$a\0icon\x1f$a\n"; done |
rofi \
    -dmenu \
    -theme "${SCRIPT_DIR}"/wallpaper-select.rasi \
    -show-icons)

## Quit if P is empty
if [ -z "$P" ]; then 
  exit
fi

NID=$(notify-send -p "Changing wallpaper" "Generating colors..." -h int:value:5 -a "Wallpaper Switcher")

function PRINT_USAGE() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -r  Skip reloading applications"
  echo "  -g  Skip generating GTK themes"
  echo "  -q  Skip generating Qt styles"
  echo "  -i  Skip generating icon theme"
}

function GENERATE_COLORS() {
  wal --cols16 lighten -i ~/Pictures/wallpapers/"$P"

  cp ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors.css
  cp ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/shared/colors.rasi
  cp ~/.cache/wal/yazi-theme.toml ~/.config/yazi/theme.toml
  cp ~/.cache/wal/colors.Xresources ~/.Xresources
}

function RELOAD_APPS(){
  notify-send -r "$NID" "Changing Wallpaper" "Reloading apps..." -h int:value:10 -a "Wallpaper Switcher"

  swaync-client -rs

  pkill waybar
  hyprctl dispatch exec "waybar"

  pkill swaybg
  hyprctl dispatch exec "swaybg -i ~/Pictures/wallpapers/$P"
}

function GENERATE_GTK_THEMES(){
  notify-send -r "$NID" "Changing Wallpaper" "Generating Gtk2/3 themes..." -h int:value:15 -a "Wallpaper Switcher"
  xrdb -merge ~/.Xresources
  oomox-cli /opt/oomox/scripted_colors/xresources/xresources-reverse
  notify-send -r "$NID" "Changing Wallpaper" "Generating Gtk4 theme..." -h int:value:35 -a "Wallpaper Switcher"
  python "${BASE16CLI}" "${GTK4_TEMPLATE}" "${TEMPLATE}" > "$HOME/.themes/$THEMENAME/gtk-4.0/gtk.css"
  sed -i '/^Import Colors/d' "$HOME/.themes/$THEMENAME/gtk-4.0/gtk.css"
  cp "$HOME/.themes/$THEMENAME/gtk-4.0/gtk.css" "$HOME/.config/gtk-4.0/gtk.css"
}

function GENERATE_QT_STYLE() {
  notify-send -r "$NID" "Changing Wallpaper" "Generating Qt themes..." -h int:value:55 -a "Wallpaper Switcher"
  if [ -d "${QT_STYLE_THEMES}" ]; then
    cp ~/.cache/wal/oomox-base16.yml "$TEMPLATE"
    python "${BASE16CLI}" "${QT_STYLE_TEMPLATE}" "${TEMPLATE}" > "${QT_STYLE_THEMES}"/oomox.css
    sed -i '/^Import Colors/d' "${QT_STYLE_THEMES}"/oomox.css
  else
    notify-send --icon=error --urgency=critical "Error outputing Qt Stylesheet" "${QT_STYLE_THEMES} does not exist"
  fi
}

function GENERATE_ICONS() {
  notify-send -r "$NID" "Changing Wallpaper" "Generating icon theme..." -h int:value:75 -a "Wallpaper Switcher"
  /opt/oomox/plugins/icons_gnomecolors/gnome-colors-icon-theme/change_color.sh -o "${THEMENAME}" "${OOMOXCOLOR}"
}

while getopts "rgqi" opt; do
  case $opt in
    r)
      SKIP_RELOAD=1
      ;;
    g)
      SKIP_GTK=1
      ;;
    q)
      SKIP_QT=1
      ;;
    i)
      SKIP_ICONS=1
      ;;
    *)
      PRINT_USAGE
      notify-send -r "$NID" "Error" "Invalid option: $opt" -a "Wallpaper Switcher" -w -i error
      ;;
  esac
done

GENERATE_COLORS
[ -n "$SKIP_RELOAD" ] || RELOAD_APPS
[ -n "$SKIP_GTK" ] || GENERATE_GTK_THEMES
[ -n "$SKIP_QT" ] || GENERATE_QT_STYLE
[ -n "$SKIP_ICONS" ] || GENERATE_ICONS

notify-send -r "$NID" "Wallpaper Changed" "Finishing switching wallpaper to $P" -a "Wallpaper Switcher"
