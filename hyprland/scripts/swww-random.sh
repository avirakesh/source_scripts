#!/bin/bash

# Path to hyprland config to extract monitor names
HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
STATE_DIR="$HOME/.cache/swww"
mkdir -p "$STATE_DIR"

# Extract monitor names from variables
MON_PORTRAIT=$(grep "\$leftMonitor =" "$HYPR_CONF" | cut -d '=' -f 2 | xargs)
MON_LANDSCAPE=$(grep "\$rightMonitor =" "$HYPR_CONF" | cut -d '=' -f 2 | xargs)

CACHE_DIR="$HOME/.cache/auto-wallpaper"
LANDSCAPE_DIR="$CACHE_DIR/landscape"
PORTRAIT_DIR="$CACHE_DIR/portrait"

# Ensure swww-daemon is running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi

# Function to get random image different from the current one
get_unique_random_image() {
    local dir="$1"
    local monitor_name="$2"
    local last_img_file="$STATE_DIR/last_$monitor_name"
    local last_img=""
    
    [[ -f "$last_img_file" ]] && last_img=$(cat "$last_img_file")

    if [[ -d "$dir" ]]; then
        # List all files, exclude the last one, and pick one randomly
        local next_img
        next_img=$(find "$dir" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" -o -name "*.jpeg" \) | grep -vF "$last_img" | shuf -n 1)
        
        # Fallback if only one image exists in the directory
        if [[ -z "$next_img" ]]; then
            next_img=$(find "$dir" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" -o -name "*.jpeg" \) | shuf -n 1)
        fi
        
        echo "$next_img"
        echo "$next_img" > "$last_img_file"
    fi
}

# Set Portrait wallpaper
if [[ -n "$MON_PORTRAIT" ]]; then
    IMG_P=$(get_unique_random_image "$PORTRAIT_DIR" "$MON_PORTRAIT")
    if [[ -n "$IMG_P" ]]; then
        swww img -o "$MON_PORTRAIT" "$IMG_P" --transition-type random --transition-step 20 --transition-fps 60
    fi
fi

# Set Landscape wallpaper
if [[ -n "$MON_LANDSCAPE" ]]; then
    IMG_L=$(get_unique_random_image "$LANDSCAPE_DIR" "$MON_LANDSCAPE")
    if [[ -n "$IMG_L" ]]; then
        swww img -o "$MON_LANDSCAPE" "$IMG_L" --transition-type random --transition-step 20 --transition-fps 60
    fi
fi
