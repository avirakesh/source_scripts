#!/bin/bash
set -euo pipefail

# Get the script directory
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../style_helpers.sh"

header "Setting up Vim"
echo ""

if ! command -v vim &>/dev/null; then
    error "Vim is not installed. Exiting..."
    exit 1
fi

# root dir of vim config
config_dir="$HOME/.vim"

info "Creating vim configuration directories"
mkdir -p "$config_dir"/{bundle,backup,backupf}
echo ""

vimrc="$HOME/.vimrc"

info "Installing Vundle"
if [[ -d "$config_dir/bundle/Vundle.vim" ]]; then
    rm -rf "$config_dir/bundle/Vundle.vim"
fi

git clone https://github.com/VundleVim/Vundle.vim.git "$config_dir/bundle/Vundle.vim"
echo ""

# Handle existing vimrc or symlink
if [[ -L "$vimrc" ]]; then
    rm "$vimrc"
    info "Removed existing symlink at $vimrc"
elif [[ -f "$vimrc" ]]; then
    mv "$vimrc" "$vimrc.bak0"
    info "Moved existing file to $vimrc.bak0"
fi

local_vimrc="$SCRIPT_DIR/vimrc"
if [[ "${1:-}" == "--min" ]]; then
    local_vimrc="$SCRIPT_DIR/min.vimrc"
    info "Using minimal vimrc"
fi

# Create a symlink to the config file
info "Symlinking $local_vimrc to $vimrc"
ln -s "$local_vimrc" "$vimrc"
echo ""

# Install plugins using Vundle
info "Installing plugins with Vundle (this may take a moment)"
vim +PluginInstall +PluginClean +qall
echo ""

success "Vim setup complete!"
