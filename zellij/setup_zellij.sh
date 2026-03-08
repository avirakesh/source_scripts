#!/bin/bash
set -euo pipefail

# Get the script directory
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../style_helpers.sh"

header "Setting up Zellij"
echo ""

# Define the paths for the config file and symlink destination
config_file_path="$SCRIPT_DIR/config.kdl"
zellij_config_dir="$HOME/.config/zellij"
symlink_destination="$zellij_config_dir/config.kdl"

if ! command -v zellij &>/dev/null; then
    warn "Zellij is not installed. Proceeding anyway."
    echo ""
fi

mkdir -p "$zellij_config_dir"

# Handle existing config file or symlink
if [[ -L "$symlink_destination" ]]; then
    rm "$symlink_destination"
    info "Removed existing symlink at $symlink_destination"
elif [[ -f "$symlink_destination" ]]; then
    mv "$symlink_destination" "$symlink_destination.bak0"
    info "Moved existing file to $symlink_destination.bak0"
fi

# Create a symlink to the config file
info "Symlinking $config_file_path to $symlink_destination"
ln -s "$config_file_path" "$symlink_destination"
echo ""

success "Zellij setup complete!"
