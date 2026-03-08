# Check if sheldon should update (every 7 days)
_sheldon_update_check() {
    local last_update="${XDG_CACHE_HOME:-$HOME/.cache}/sheldon_last_update"
    mkdir -p "$(dirname "$last_update")"
    
    # Define local UI helpers since style_helpers is for repo scripts only
    local GREEN='\033[0;32m'
    local RED='\033[0;31m'
    local WHITE='\033[0;37m'
    local RESET='\033[0m'

    _sheldon_info() { echo -e "${WHITE}🔹 $*${RESET}"; }
    _sheldon_success() { echo -e "${GREEN}✅ ✔ $*${RESET}"; }
    _sheldon_error() { echo -e "${RED}❌ $*${RESET}"; }

    # Print last update time if it exists
    if [[ -f "$last_update" ]]; then
        local last_date=$(date -r "$last_update" "+%Y-%m-%d %H:%M:%S")
        _sheldon_info "Sheldon plugins last updated: $last_date"
    fi

    # If file doesn't exist or is older than 7 days
    if [[ ! -f "$last_update" ]] || [[ -n "$(find "$last_update" -mtime +7 2>/dev/null)" ]]; then
        # Check if sheldon is installed
        if command -v sheldon > /dev/null; then
            _sheldon_info "Updating sheldon plugins (this may take a few seconds)..."

            # Run synchronously as requested
            if sheldon lock --update; then
                touch "$last_update"
                _sheldon_success "Sheldon plugins updated."
            else
                _sheldon_error "Sheldon update failed."
            fi
        fi
    fi

    unset -f _sheldon_info _sheldon_success _sheldon_error
}

_sheldon_update_check
unset -f _sheldon_update_check
