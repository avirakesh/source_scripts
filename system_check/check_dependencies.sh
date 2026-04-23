#!/bin/bash
set -euo pipefail

# ANSI Color Codes
RED='\e[31m'
GREEN='\e[32m'
BLUE='\e[34m'
YELLOW='\e[33m'
CYAN='\e[36m'
RESET='\e[0m'

echo "-------------------------------------------"
echo "       System Dependency Check           "
echo "------------------------------------------"
echo ""

# Detect OS
OS_TYPE=$(uname -s)
echo -e "${CYAN}Launching check on ${YELLOW}$OS_TYPE${CYAN} environment...${RESET}"
echo ""

# Common dependencies across all platforms
dependencies=(
    "sheldon"
    "git"
    "starship"
    "zsh"
    "vim"
    "zellij"
    "emacs"
)

# Linux-specific dependencies (Hyprland ecosystem)
if [[ "$OS_TYPE" == "Linux" ]]; then
    dependencies+=(
        "alacritty"
        "hyprland"
        "wofi"
        "waybar"
        "swww"
        "hyprlock"
    )
fi

# Remove duplicates
unique_dependencies=($(printf "%s\n" "${dependencies[@]}" | sort -u))

missing_count=0

for tool in "${unique_dependencies[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
        echo -e "    [${RED}✗${RESET}] $tool"
        missing_count=$((missing_count + 1))
    else
        echo -e "    [${GREEN}✓${RESET}] $tool"
    fi
done

echo ""
if [[ $missing_count -eq 0 ]]; then
    echo -e "${GREEN}Success: All dependencies are installed!${RESET}"
    exit 0
else
    echo -e "${RED}Error: $missing_count dependency(ies) are missing.${RESET}"
    exit 1
fi
