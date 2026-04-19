#!/usr/bin/env bash

# 1. Define where your JSON themes are saved
# Pywal usually stores custom/saved themes here, or you can create your own folder
THEME_DIR="$HOME/.cache/wal/schemes" 

# Make sure the directory exists and has files to avoid errors
if [[ ! -d "$THEME_DIR" ]]; then
    echo "Directory $THEME_DIR does not exist."
    exit 1
fi

declare -A theme_files
menu_items=""

# 2. Loop through all JSON files and extract the colors
for file in "$THEME_DIR"/*.json; do
    # Get the filename without the .json extension
    wp=$(jq -r '.wallpaper' "$file")
    theme_name=$(basename "$wp")
    
    # Extract a few accent colors to show in the preview using jq
    c1=$(jq -r '.colors.color1' "$file")
    c2=$(jq -r '.colors.color2' "$file")
    c3=$(jq -r '.colors.color3' "$file")
    c4=$(jq -r '.colors.color4' "$file")
    c5=$(jq -r '.colors.color5' "$file")
    
    # 3. Create the visual palette using Pango markup and block characters (█)
    palette="<span color='$c1'>██</span> <span color='$c2'>██</span> <span color='$c3'>██</span> <span color='$c4'>██</span> <span color='$c5'>██</span>"
    
    # Format the line: "Theme_Name       ██ ██ ██ ██ ██"
    # The \t (tab) helps keep the blocks aligned
    line="${theme_name}\t${palette}"
    
    # Add it to our list of options
    menu_items+="${line}\n"
    
    # Map the display name to the actual file path for later
    theme_files["$theme_name"]="$file"
done

# 4. Pipe the formatted list into Rofi
# -markup-rows is required to parse the <span> tags!
selected_line=$(echo -e -n "$menu_items" | rofi -dmenu -i -markup-rows -p "🎨 Select Theme")

# 5. Handle the selection
if [[ -n "$selected_line" ]]; then
    # Extract just the theme name (everything before the first tab/space)
    selected_theme=$(echo "$selected_line" | awk '{print $1}')
    selected_file="${theme_files[$selected_theme]}"
    
    # Extract the wallpaper path from the chosen JSON
    wallpaper_path=$(jq -r '.wallpaper' "$selected_file")
    
    # Apply the theme with pywal! 
    # Use -i to set the wallpaper, or --theme to just apply the colors
    if [[ -f "$wallpaper_path" ]]; then
        wal -i "$wallpaper_path"
    else
        wal --theme "$selected_file"
    fi
    
    # Optional: Reload your window manager, polybar, or dunst here
    # killall -SIGUSR1 kitty  # Example: live-reload kitty terminal
fi
