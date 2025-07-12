#!/bin/bash
set -euo pipefail

# Define the colors for output
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
reset="\033[0m"
bold="\033[1m"
normal=$(tput sgr0)

# Get the current directory of the script
current_directory="$(dirname "$0")"
current_directory="$(realpath "$current_directory")"

# root dir of vim config
config_dir="$HOME/.emacs.d"

echo -e "Creating $green$config_dir$reset"
mkdir -p "$config_dir"

sanemacs_url="https://sanemacs.com/sanemacs.el"
sanemacs_file="$config_dir/sanemacs.el"
echo -e "Downloading ${yellow}sanemacs$reset to ${green}$sanemacs_file$reset"
curl "$sanemacs_url" > "$sanemacs_file"

echo ""

target_init_el="$config_dir/init.el"

echo -e ""
# Check if the symlink already exists
if [[ -L "$target_init_el" ]]; then
    # Delete the symlink
    rm "$target_init_el"
    echo -e "Deleted symlink at $red$target_init_el$reset"
elif [[ -f "$target_init_el" ]]; then
    # Move the existing file to a backup
    mv "$target_init_el" "$target_init_el.bak0"
    echo -e "Moved file at $red$target_init_el$reset to $green$target_init_el.bak0$reset"
fi

src_init_el="$current_directory/init.el"

# Create a symlink to the config file
echo -e "Symlinking $yellow$src_init_el$reset to $green$target_init_el$reset"
ln -s "$src_init_el" "$target_init_el"


echo ""
target_emacs_bin_dir="$HOME/bin"
target_emacsw_bin="$target_emacs_bin_dir/emacsw"

mkdir -p "$target_emacs_bin_dir"
# Check if the symlink already exists
if [[ -L "$target_emacsw_bin" ]]; then
    # Delete the symlink
    rm "$target_emacsw_bin"
    echo -e "Deleted symlink at $red$target_emacsw_bin$reset"
elif [[ -f "$target_emacsw_bin" ]]; then
    # Move the existing file to a backup
    mv "$target_emacsw_bin" "$target_emacsw_bin.bak0"
    echo -e "Moved file at $red$target_emacsw_bin$reset to $green$target_emacsw_bin.bak0$reset"
fi


src_emacsw_bin="$current_directory/emacsw"
# Create a symlink to the config file
echo -e "Symlinking $yellow$src_emacsw_bin$reset to $green$target_emacsw_bin$reset"
ln -s "$src_emacsw_bin" "$target_emacsw_bin"

echo -e ""
echo -e "${bold}${green}emacs setup done!$reset"

if [[ "$OSTYPE" != "darwin"* ]]; then
    echo ""
    echo "Linux Detected"
    echo "You may have to run the following command to set emacsw as the default editor"
    echo -e "    ${yellow}sudo update-alternatives --install /usr/bin/editor editor ${target_emacsw_bin} 2 && \\ $reset"
    echo -e "        ${yellow}sudo update-alternatives --set editor $target_emacsw_bin$reset"
fi
