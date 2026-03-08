#!/bin/bash
set -euo pipefail

# Get the script directory
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../style_helpers.sh"

header "Setting up Git"
echo ""

# Check if git is installed
if ! command -v git &>/dev/null; then
    error "Git not found. Please install it first."
    exit 1
fi

git_templates_path="$SCRIPT_DIR/git_templates"

info "Setting git templateDir to $git_templates_path"
git config --global init.templateDir "$git_templates_path"
echo ""

success "Git setup complete!"
