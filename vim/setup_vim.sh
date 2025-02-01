#!/bin/bash
set -euo pipefail

# Define the colors for output
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
reset="\033[0m"
bold="\033[1m"
normal=$(tput sgr0)

if ! command -v vim &>/dev/null; then
    echo -e "$red""vim not installed. Exiting...""$reset"
    exit 1
fi

# Get the current directory of the script
current_directory="$(dirname "$0")"
current_directory="$(realpath "$current_directory")"

# root dir of vim config
config_dir="$HOME/.vim"

echo -e "Creating $green$config_dir$reset"
mkdir -p "$config_dir"

echo -e "Creating $config_dir/${green}bundle$reset"
mkdir -p "$config_dir/bundle"

echo -e "Creating $config_dir/${green}backup$reset"
mkdir -p "$config_dir/backup"

echo -e "Creating $config_dir/${green}backupf$reset"
mkdir -p "$config_dir/backupf"

vimrc="$HOME/.vimrc"

echo -e ""
echo -e "Installing Vundle"
if [[ -d "$config_dir/bundle/Vundle.vim" ]]; then
    echo -e "Vundle already exists. ${red}Deleting.$reset"
    rm -rf "$config_dir/bundle/Vundle.vim"
fi

echo -e "Cloning Vundle.vim into $config_dir/bundle/Vundle.vim"
git clone https://github.com/VundleVim/Vundle.vim.git "$config_dir/bundle/Vundle.vim"

echo -e ""
# Check if the symlink already exists
if [[ -L "$vimrc" ]]; then
    # Delete the symlink
    rm "$vimrc"
    echo -e "Deleted symlink at $red$vimrc$reset"
elif [[ -f "$vimrc" ]]; then
    # Move the existing file to a backup
    mv "$vimrc" "$vimrc.bak0"
    echo -e "Moved file at $red$vimrc$reset to $green$vimrc.bak0$reset"
fi

local_vimrc="$current_directory/vimrc"

# Create a symlink to the config file
echo -e "Symlinking $yellow$local_vimrc$reset to $green$vimrc$reset"
ln -s "$local_vimrc" "$vimrc"

# Install plugins using Vundle
echo -e ""
echo -e "Installing plugins with Vundle"
vim +PluginInstall +PluginClean +qall

echo -e ""
echo -e "$bold$green""vim setup done!""$normal"
