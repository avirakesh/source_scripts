#!/bin/bash
set -euo pipefail

# Get the script directory
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../style_helpers.sh"

header "Setting up Sheldon"
echo ""

# Define the paths for the config file and symlink destination
config_file_path="$SCRIPT_DIR/plugins.toml"
custom_plugins_path="$SCRIPT_DIR/custom_plugins"
config_dir="$HOME/.config/sheldon"
symlink_destination="$config_dir/plugins.toml"
custom_plugins_destination="$config_dir/custom_plugins"

# Check if sheldon is installed
if ! command -v sheldon &>/dev/null; then
    error "Sheldon is not installed. Please install it to use this setup."
    exit 1
fi

# Create config directory
if [[ ! -d "$config_dir" ]]; then
    info "Creating directory for sheldon config at $config_dir"
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

# Handle existing custom_plugins or symlink
if [[ -L "$custom_plugins_destination" ]]; then
    rm "$custom_plugins_destination"
    info "Removed existing symlink at $custom_plugins_destination"
elif [[ -d "$custom_plugins_destination" ]]; then
    backup="$custom_plugins_destination.bak_$(date +%Y%m%d%H%M%S)"
    mv "$custom_plugins_destination" "$backup"
    info "Moved existing directory to $backup"
fi

# Create a symlink to the config file
info "Symlinking $config_file_path to $symlink_destination"
ln -s "$config_file_path" "$symlink_destination"

# Create a symlink to the custom_plugins directory if it exists
if [[ -d "$custom_plugins_path" ]]; then
    info "Symlinking $custom_plugins_path to $custom_plugins_destination"
    ln -s "$custom_plugins_path" "$custom_plugins_destination"
fi
echo ""

success "Sheldon setup complete!"
echo ""
attention "Remember to add 'eval \"\$(sheldon source)\"' to your .zshrc file."
