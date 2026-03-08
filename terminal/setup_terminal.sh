#!/bin/bash
set -euo pipefail

# Get the script directory
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../style_helpers.sh"

header "Setting up Terminal (fzf)"
echo ""

fzf_dir="$HOME/.fzf"

info "Cleaning up existing fzf installation at $fzf_dir"
rm -rf "$fzf_dir"

info "Cloning fzf repository"
git clone --depth 1 https://github.com/junegunn/fzf.git "$fzf_dir"

info "Running fzf install script"
"$fzf_dir/install" --all
echo ""

success "fzf setup complete!"
