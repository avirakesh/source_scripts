#!/bin/bash
set -euo pipefail

# Get the script directory
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../style_helpers.sh"

header "Setting up Alacritty"
echo ""

# Define the paths for the config file and symlink destination
config_file_path="$SCRIPT_DIR/alacritty.toml"
config_dir="$HOME/.config/alacritty"
symlink_destination="$config_dir/alacritty.toml"
themes_dir="$config_dir/themes"

if ! command -v alacritty &>/dev/null; then
    warn "Alacritty is not installed. Proceeding anyway."
    echo ""
fi

if [[ ! -d "$themes_dir" ]]; then
    info "Creating directory for themes at $themes_dir"
    mkdir -p "$themes_dir"
fi

themes_url="https://github.com/alacritty/alacritty-theme"
if [[ -z "$(ls -A "$themes_dir")" ]]; then
    info "Fetching themes from $themes_url"
    git clone --depth 1 "$themes_url" "$themes_dir"
else
    info "Themes already present at $themes_dir. Not downloading."
fi
echo ""

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

success "Alacritty setup complete!"
