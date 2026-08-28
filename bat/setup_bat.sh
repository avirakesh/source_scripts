#!/bin/bash
set -euo pipefail

# Get the script directory
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../style_helpers.sh"

header "Setting up bat"
echo ""

# Define the paths for the config file and symlink destination
config_file_path="$SCRIPT_DIR/config"
config_dir="$HOME/.config/bat"
symlink_destination="$config_dir/config"

# Check if bat is installed
if ! command -v bat &>/dev/null; then
    error "bat is not installed. Please install it to use this setup."
    exit 1
fi

# Create config directory if it doesn't exist
if [[ ! -d "$config_dir" ]]; then
    info "Creating directory for bat config at $config_dir"
    mkdir -p "$config_dir"
    echo ""
fi

# Handle existing config file or symlink
if [[ -L "$symlink_destination" ]]; then
    rm "$symlink_destination"
    info "Removed existing symlink at $symlink_destination"
elif [[ -f "$symlink_destination" ]]; then
    backup="$symlink_destination.bak_$(date +%Y%m%d%H%M%S)"
    mv "$symlink_destination" "$backup"
    info "Moved existing file to $backup"
fi

# Create a symlink to the config file
info "Symlinking $config_file_path to $symlink_destination"
ln -s "$config_file_path" "$symlink_destination"
echo ""

success "bat setup complete!"
