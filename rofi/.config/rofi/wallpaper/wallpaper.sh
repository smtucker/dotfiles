#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Configuration
declare -A CONFIG=(
    ["THEMENAME"]="oomox-xresources-reverse"
    ["BASE16CLI"]="/opt/oomox/plugins/base16/cli.py"
    ["OOMOXPLUGINDIR"]="/opt/oomox/plugins/"
    ["QT_STYLE_TEMPLATE"]="${OOMOXPLUGINDIR}/base16/templates/qt-oomox-styleplugin/templates/default.mustache"
    ["GTK4_TEMPLATE"]="${OOMOXPLUGINDIR}/base16/templates/gtk4-oodwaita/templates/gtk4-libadwaita1.6.0.mustache"
    ["TEMPLATE"]="$OOMOXPLUGINDIR/import_xresources/colors/xresources" # Default template, no reverse
    ["QT_STYLE_THEMES"]="$HOME/.config/oomox-qtstyleplugin/themes"
    ["OOMOXCOLOR"]="/opt/oomox/scripted_colors/xresources/xresources" # Default color, no reverse
    ["WALLPAPER_DIR"]="$HOME/Pictures/wallpapers" # Wallpaper directory
)


# --- Functions ---

function CRIT_ERROR() {
    local message="$1"
    echo "ERROR: ${message}"
    NOTIFY "${message}" critical
    return 1
}


function NOTIFY() {
    local message="$1"
    local progress="$2"
    local urgency="$3"
    local options=""

    if [ -n "${progress}" ]; then
        options+="-h int:value:${progress} "
    fi

    if [ -n "${urgency}" ]; then
        options+="--urgency=${urgency} "
    fi

    if [ -n "$NID" ]; then
        notify-send -a "Wallpaper Switcher" -r "$NID" "${message}" ${options}
    else
        NID=$(notify-send -p -a "Wallpaper Switcher" "${message}" ${options} -h int:value:0)
    fi
}


function SET_MODE() {
    case "$1" in
        Light)
            LIGHTMODE=lighten
            ;;
        Dark)
            LIGHTMODE=darken
            REVERSE="-reverse"
            ;;
        *) CRIT_ERROR "Invalid mode" ; exit ;;
    esac

    # Update config template and color based on mode.
    CONFIG["TEMPLATE"]="${CONFIG["OOMOXPLUGINDIR"]}/import_xresources/colors/xresources${REVERSE}"
    CONFIG["OOMOXCOLOR"]="/opt/oomox/scripted_colors/xresources/xresources${REVERSE}"
}


function SELECT_WALLPAPER() {
    cd "${CONFIG[WALLPAPER_DIR]}" || CRIT_ERROR "Cannot find wallpaper directory"

    local selection
    selection=$(for a in *; do echo -en "$a\0icon\x1f$a\n"; done |
        rofi \
            -dmenu \
            -theme "${SCRIPT_DIR}"/wallpaper-select.rasi)

    # Quit if selection is empty.
    if [ -z "$selection" ]; then
        exit
    fi
    echo "$selection"
}


function PRINT_USAGE() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -r  Skip reloading applications"
  echo "  -g  Skip generating GTK themes"
  echo "  -q  Skip generating Qt styles"
  echo "  -i  Skip generating icon theme"
}


function GENERATE_COLORS() {
    NOTIFY "Generating colors..." 5
    wal --cols16 "$LIGHTMODE" -i "${CONFIG[WALLPAPER_DIR]}/$P"

    cp ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors.css
    cp ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/shared/colors.rasi
    cp ~/.cache/wal/yazi-theme.toml ~/.config/yazi/theme.toml
    cp ~/.cache/wal/colors.Xresources ~/.Xresources
}


function RELOAD_APPS() {
    NOTIFY "Reloading apps..." 10
    swaync-client -rs

    pkill waybar
    hyprctl dispatch exec "waybar"

    pkill swaybg
    hyprctl dispatch exec "swaybg -i ${CONFIG[WALLPAPER_DIR]}/$P"
}


function GENERATE_GTK_THEMES() {
    NOTIFY "Generating Gtk2/3 themes..." 15
    xrdb -merge ~/.Xresources
    oomox-cli "${CONFIG[OOMOXCOLOR]}" -o "${CONFIG[THEMENAME]}"

    NOTIFY "Generating Gtk4 theme..." 35
    python "${CONFIG[BASE16CLI]}" "${CONFIG[GTK4_TEMPLATE]}" "${CONFIG[TEMPLATE]}" > "$HOME/.themes/${CONFIG[THEMENAME]}/gtk-4.0/gtk.css"
    sed -i '/^Import Colors/d' "$HOME/.themes/${CONFIG[THEMENAME]}/gtk-4.0/gtk.css"
    cp "$HOME/.themes/${CONFIG[THEMENAME]}/gtk-4.0/gtk.css" "$HOME/.config/gtk-4.0/gtk.css"
}


function GENERATE_QT_STYLE() {
    NOTIFY "Generating Qt themes..." 55
    if [ -d "${CONFIG[QT_STYLE_THEMES]}" ]; then
        cp ~/.cache/wal/oomox-base16.yml "${CONFIG[TEMPLATE]}"
        python "${CONFIG[BASE16CLI]}" "${CONFIG[QT_STYLE_TEMPLATE]}" "${CONFIG[TEMPLATE]}" > "${CONFIG[QT_STYLE_THEMES]}/oomox.css"
        sed -i '/^Import Colors/d' "${CONFIG[QT_STYLE_THEMES]}/oomox.css"
    else
        notify-send --icon=error --urgency=critical "Error outputing Qt Stylesheet" "${CONFIG[QT_STYLE_THEMES]} does not exist"
    fi
}


function GENERATE_ICONS() {
    NOTIFY "Generating icon theme..." 75
    /opt/oomox/plugins/icons_gnomecolors/gnome-colors-icon-theme/change_color.sh -o "${CONFIG[THEMENAME]}" "${CONFIG[OOMOXCOLOR]}"
}


# --- Main execution ---

MODE=$(printf "Light\nDark\n" | rofi -dmenu -theme "${SCRIPT_DIR}"/mode-select.rasi)
SET_MODE "$MODE"

P=$(SELECT_WALLPAPER)

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

NOTIFY "Wallpaper Changed to $P"
