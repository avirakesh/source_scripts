#!/bin/bash

STATE_DIR="$HOME/.cache/swww"
mkdir -p "$STATE_DIR"

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

        if [[ -n "$next_img" ]]; then
            echo "$next_img"
            echo "$next_img" > "$last_img_file"
        fi
    fi
}

# Get monitors using hyprctl and set wallpaper based on orientation
hyprctl monitors -j | jq -c '.[]' | while read -r monitor; do
    MON_NAME=$(echo "$monitor" | jq -r '.name')
    MON_WIDTH=$(echo "$monitor" | jq -r '.width')
    MON_HEIGHT=$(echo "$monitor" | jq -r '.height')

    # Determine if portrait or landscape
    if [ "$MON_WIDTH" -gt "$MON_HEIGHT" ]; then
        DIR="$LANDSCAPE_DIR"
    else
        DIR="$PORTRAIT_DIR"
    fi

    IMG=$(get_unique_random_image "$DIR" "$MON_NAME")
    if [[ -n "$IMG" ]]; then
        swww img -o "$MON_NAME" "$IMG" --transition-type random --transition-step 20 --transition-fps 60
    fi
done
