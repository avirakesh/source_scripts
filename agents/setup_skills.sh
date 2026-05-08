#!/bin/bash
set -euo pipefail

# Get the script directory
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
# Find the root directory by looking for style_helpers.sh
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$ROOT_DIR/style_helpers.sh"

header "Installing all skills from agents/skill"
echo ""

SKILL_ROOT="$ROOT_DIR/agents/skill"
SKILL_DEST_BASE="$HOME/.agents/skills"

# Check if the source directory exists
if [[ ! -d "$SKILL_ROOT" ]]; then
    error "Source directory $SKILL_ROOT not found."
    exit 1
fi

    # Ensure destination base directory exists
    if [[ ! -d "$SKILL_DEST_BASE" ]]; then
        attention "Creating destination directory $SKILL_DEST_BASE"
        mkdir -p "$SKILL_DEST_BASE"
    fi

    # Iterate through all directories in agents/skill/
    # Using find to get directories only and avoid issues with spaces/special chars
    find "$SKILL_ROOT" -maxdepth 1 -mindepth 1 -type d | while read -r SKILL_PATH; do
        SKILL_NAME=$(basename "$SKILL_PATH")
        SKILL_DEST_DIR="$SKILL_DEST_BASE/$SKILL_NAME"
        SKILL_DEST="$SKILL_DEST_DIR"

        # Handle existing symlink or file at the destination
        if [[ -L "$SKILL_DEST" ]]; then
            warn "Removing existing symlink at $SKILL_DEST"
            rm "$SKILL_DEST"
        elif [[ -f "$SKILL_DEST" || -d "$SKILL_DEST" ]]; then
            backup="$SKILL_DEST.bak_$(date +%Y%m%d%H%M%S)"
            warn "Moving existing item to $backup"
            mv "$SKILL_DEST" "$backup"
        fi

        # Create the symlink for the directory
        ln -s "$SKILL_PATH" "$SKILL_DEST"
        success "Symlinked $SKILL_NAME"
        
        echo ""
    done

echo ""
success "All skills from $SKILL_ROOT have been installed to $SKILL_DEST_BASE!"
echo ""
