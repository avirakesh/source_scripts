#!/bin/bash
set -euo pipefail

# Get the current directory of the script
current_directory="$(dirname "$(realpath "$0")")"

# Define the paths for the config file and symlink destination
config_file_path="$current_directory/plugins.toml"
config_dir="$HOME/.config/sheldon"
symlink_destination="$config_dir/plugins.toml"

# Define the colors for output
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
reset="\033[0m"
bold="\033[1m"
normal=$(tput sgr0)

# Check if sheldon is installed
if [[ -z "$(which sheldon)" ]]; then
    echo -e "$bold$yellow""Warning:""$normal""$red sheldon$normal is not installed. Please install it to use this setup." >&2
    exit 1
fi

# Create config directory
if [[ ! -d "$config_dir" ]]; then
    echo -e "Creating directory for sheldon config at $green$config_dir$reset"
    mkdir -p "$config_dir"
fi

# Check if the symlink already exists
if [[ -L "$symlink_destination" ]]; then
    # Delete the symlink
    rm "$symlink_destination"
    echo -e "Deleted existing symlink at $red$symlink_destination$reset"
elif [[ -f "$symlink_destination" ]]; then
    # Move the existing file to a backup
    mv "$symlink_destination" "$symlink_destination.bak_$(date +%Y%m%d%H%M%S)"
    echo -e "Moved existing file at $red$symlink_destination$reset to $green$symlink_destination.bak_$(date +%Y%m%d%H%M%S)$reset"
fi

# Create a symlink to the config file
echo -e "Symlinking $yellow$config_file_path$reset to $green$symlink_destination$reset"
ln -s "$config_file_path" "$symlink_destination"

echo ""
echo -e "$bold$green""Sheldon Setup Done!""$normal"
echo -e "$bold$yellow""Remember to add 'eval "\$\(sheldon source\)"' to your .zshrc file.""$normal"
