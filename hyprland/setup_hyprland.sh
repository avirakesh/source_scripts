#!/bin/bash
set -euo pipefail

# Get the script directory
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../style_helpers.sh"

header "Setting up Hyprland"
echo ""

# Define the destination directory
config_dir="$HOME/.config/hypr"

# Check if Hyprland is installed (just checking if the directory exists is a proxy here)
if [[ ! -d "$config_dir" ]]; then
    warn "Hyprland config directory $config_dir does not exist. Creating it."
    mkdir -p "$config_dir"
fi

# Iterate over files in the repo's hyprland directory
# We want to symlink the files from the repo to the destination
# We should avoid symlinking the setup script itself or anything else not part of the config

# List of files/directories to symlink
# Based on the ls -F output: hyprland.conf, hyprlock.conf, scripts, waybar, wofi, swaync
targets=("hyprland.conf" "hyprlock.conf" "scripts" "waybar" "wofi" "swaync")

for target in "${targets[@]}"; do
    src_path="$SCRIPT_DIR/$target"
    
    # Standard location for wofi is ~/.config/wofi, swaync is ~/.config/swaync
    if [[ "$target" == "wofi" ]]; then
        dest_path="$HOME/.config/wofi"
    elif [[ "$target" == "swaync" ]]; then
        dest_path="$HOME/.config/swaync"
    else
        dest_path="$config_dir/$target"
    fi

    if [[ ! -e "$src_path" ]]; then
        warn "Source $src_path does not exist. Skipping."
        continue
    fi

    # Handle existing file or symlink at destination
    if [[ -L "$dest_path" ]]; then
        rm "$dest_path"
        warn "Removed existing symlink at $dest_path"
    elif [[ -f "$dest_path" || -d "$dest_path" ]]; then
        mv "$dest_path" "$dest_path.bak0"
        warn "Moved existing file/directory to $dest_path.bak0"
    fi

    # Create the symlink
    info "Symlinking $src_path to $dest_path"
    ln -s "$src_path" "$dest_path"
    echo ""
done

echo ""
success "Hyprland setup complete!"
