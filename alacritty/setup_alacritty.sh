#!/bin/bash
set -euo pipefail

# Get the current directory of the script
current_directory="$(dirname "$0")"
current_directory="$(realpath "$current_directory")"

# Define the paths for the config file and symlink destination
config_file_path="$current_directory/alacritty.toml"
config_dir="$HOME/.config/alacritty"
symlink_destination="$config_dir/alacritty.toml"

themes_dir="$config_dir/themes"

# Define the colors for output
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
reset="\033[0m"
bold="\033[1m"
normal=$(tput sgr0)

if [[ -z "$(which alacritty)" ]]; then
    echo -e "$bold$yellow""Warning:""$normal""$red alacritty$normal is not installed. Proceeding anyway."
fi

if [[ ! -d "$themes_dir" ]]; then
    echo -e "Creating directory for themes at $green$themes_dir$reset"
    mkdir -p "$themes_dir"
fi

themes_url="https://github.com/alacritty/alacritty-theme"
if [[ -z $(ls $themes_dir) ]]; then
    echo -e "Fetching themes from $green$themes_url$reset"
    git clone --depth 1 "$themes_url" "$themes_dir"
    echo ""
else
    echo -e "Files already present at $yellow$themes_dir$reset. Not downloading themes."

fi

# Check if the symlink already exists
if [[ -L "$symlink_destination" ]]; then
    # Delete the symlink
    rm "$symlink_destination"
    echo -e "Deleted symlink at $red$symlink_destination$reset"
elif [[ -f "$symlink_destination" ]]; then
    # Move the existing file to a backup
    mv "$symlink_destination" "$symlink_destination.bak0"
    echo -e "Moved file at $red$symlink_destination$reset to $green$symlink_destination.bak0$reset"
fi

# Create a symlink to the config file
echo -e "Symlinking $yellow$config_file_path$reset to $green$symlink_destination$reset"
ln -s "$config_file_path" "$symlink_destination"

echo ""
echo -e "$bold$green""Alacritty Setup Done!""$normal"
