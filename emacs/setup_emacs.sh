#!/bin/bash
set -euo pipefail

# Get the script directory
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../style_helpers.sh"

header "Setting up Emacs"
echo ""

# root dir of emacs config
config_dir="$HOME/.emacs.d"
mkdir -p "$config_dir"

sanemacs_url="https://sanemacs.com/sanemacs.el"
sanemacs_file="$config_dir/sanemacs.el"
info "Downloading sanemacs.el to $sanemacs_file"
curl -s "$sanemacs_url" > "$sanemacs_file"
echo ""

target_init_el="$config_dir/init.el"

# Handle existing init.el or symlink
if [[ -L "$target_init_el" ]]; then
    rm "$target_init_el"
    info "Removed existing symlink at $target_init_el"
elif [[ -f "$target_init_el" ]]; then
    mv "$target_init_el" "$target_init_el.bak0"
    info "Moved existing file to $target_init_el.bak0"
fi

src_init_el="$SCRIPT_DIR/init.el"
if [[ "${1:-}" == "--min" ]]; then
    src_init_el="$SCRIPT_DIR/min.init.el"
    info "Using minimal init.el"
fi

# Create a symlink to the config file
info "Symlinking $src_init_el to $target_init_el"
ln -s "$src_init_el" "$target_init_el"
echo ""

# Symlink emacsw wrapper
target_emacs_bin_dir="$HOME/bin"
target_emacsw_bin="$target_emacs_bin_dir/emacsw"
mkdir -p "$target_emacs_bin_dir"

if [[ -L "$target_emacsw_bin" ]]; then
    rm "$target_emacsw_bin"
    info "Removed existing symlink at $target_emacsw_bin"
elif [[ -f "$target_emacsw_bin" ]]; then
    mv "$target_emacsw_bin" "$target_emacsw_bin.bak0"
    info "Moved existing file to $target_emacsw_bin.bak0"
fi

src_emacsw_bin="$SCRIPT_DIR/emacsw"
info "Symlinking $src_emacsw_bin wrapper to $target_emacsw_bin"
ln -s "$src_emacsw_bin" "$target_emacsw_bin"
echo ""

success "Emacs setup complete!"
echo ""

if [[ "$OSTYPE" != "darwin"* ]]; then
    attention "Linux Detected: You may want to set emacsw as default editor:"
    info "    sudo update-alternatives --install /usr/bin/editor editor ${target_emacsw_bin} 2 && \\"
    info "    sudo update-alternatives --set editor $target_emacsw_bin"
fi
