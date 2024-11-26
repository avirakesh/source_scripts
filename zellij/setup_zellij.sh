#!/bin/bash
set -euo pipefail

# Get the current directory of the script
current_directory="$(dirname "$0")"
current_directory="$(realpath "$current_directory")"

# Define the paths for the config file and symlink destination
config_file_path="$current_directory/config.kdl"
symlink_destination="$HOME/.config/zellij/config.kdl"

# Define the colors for output
read="\033[31m"
green="\033[32m"
yellow="\033[33m"
reset="\033[0m"
bold="\033[1m"
normal=$(tput sgr0)

# Check if the symlink already exists
if [[ -L "$symlink_destination" ]]; then
    # Delete the symlink
    rm "$symlink_destination"
    echo -e "Deleted symlink at $read$symlink_destination$reset"
elif [[ -f "$symlink_destination" ]]; then
    # Move the existing file to a backup
    mv "$symlink_destination" "$symlink_destination.bak0"
    echo -e "Moved file at $read$symlink_destination$reset to $green$symlink_destination.bak0$reset"
fi

# Create a symlink to the config file
echo -e "Symlinking $yellow$config_file_path$reset to $green$symlink_destination$reset"
ln -s "$config_file_path" "$symlink_destination"

echo ""
echo -e "$bold$green""Zellij Setup Done!""$normal"
