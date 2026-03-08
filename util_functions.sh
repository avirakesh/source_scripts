# Get the directory of this script
if [ -n "${BASH_SOURCE:-}" ]; then
    UTIL_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
else
    # Fallback for Zsh or other shells when sourced
    UTIL_DIR="$(dirname "$(realpath "${0}")")"
fi
source "$UTIL_DIR/style_helpers.sh"

function live_rsync() {
    local source_dir="$1"
    local target_dir="$2"
    local temp_exclude_file=""

    # Check if both arguments are provided
    if [ -z "$source_dir" ] || [ -z "$target_dir" ]; then
        echo "Usage: live_rsync <source_directory> <target_directory>"
        echo "Example: live_rsync . 'pi@etcherpi.local:~/projects/etch-a-sketcher'"
        return 1
    fi

    # Create a temporary file for combined rsync exclusions
    local temp_exclude_file=$(mktemp)
    if [ $? -ne 0 ]; then
        error "Could not create temporary exclude file."
        return 1
    fi

    # Ensure the temporary file is deleted when the script exits (e.g., on Ctrl+C)
    trap "rm -f \"$temp_exclude_file\"; info 'Temporary exclude file removed.'" EXIT

    # Populate the temporary exclude file
    local exclude_info=""
    if [ -n "$CUSTOM_RSYNC_EXCLUDE_PATH" ] && [ -f "$CUSTOM_RSYNC_EXCLUDE_PATH" ]; then
        cat "$CUSTOM_RSYNC_EXCLUDE_PATH" >> "$temp_exclude_file"
        exclude_info+="global exclude file"
    fi

    local gitignore_path="${source_dir}/.gitignore"
    if [ -f "$gitignore_path" ]; then
        # Add a newline before appending .gitignore content if CUSTOM_RSYNC_EXCLUDE_PATH was used
        if [ -n "$exclude_info" ]; then
            echo "" >> "$temp_exclude_file"
            exclude_info+=", "
        fi
        cat "$gitignore_path" >> "$temp_exclude_file"
        exclude_info+=".gitignore"
    fi

    header "Starting live synchronization"
    echo ""
    info "Source: $source_dir"
    info "Target: $target_dir"
    
    if [ -n "$exclude_info" ]; then
        info "Exclusions: $exclude_info"
    else
        warn "No exclude files found."
    fi
    echo ""
    info "Press Ctrl+C to stop."
    echo ""

    while inotifywait -r -e modify,create,delete "$source_dir" 2>/dev/null; do
        echo ""
        info "Change detected! Running rsync..."
        rsync -avz --delete-after --exclude-from "$temp_exclude_file" "$source_dir" "$target_dir"
        success "Rsync complete. Waiting for next change..."
    done
}

function mkcd() {
    mkdir -p "$1" && cd "$1"
}

