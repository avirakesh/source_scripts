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

# Dependency descriptions for troubleshooting
declare -A reasons
reasons["sheldon"]="Zsh plugin manager"
reasons["git"]="Version control system"
reasons["starship"]="Cross-shell customizable prompt"
reasons["zsh"]="Primary shell environment"
reasons["vim"]="Standard text editor"
reasons["zellij"]="Terminal workspace and multiplexer"
reasons["emacs"]="Extensible text editor"
reasons["alacritty"]="GPU-accelerated terminal emulator"
reasons["hyprland"]="Dynamic tiling Wayland compositor"
reasons["hyprlock"]="Hyprland's GPU-accelerated screen locking utility"
reasons["hypridle"]="Hyprland's idle management daemon"
reasons["hyprpm"]="Hyprland Plugin Manager"
reasons["wofi"]="Wayland launcher and menu program"
reasons["waybar"]="Highly customizable Wayland bar"
reasons["swww"]="Efficient animated wallpaper daemon"
reasons["swaync"]="Sway-notification-center for Wayland notifications"
reasons["dolphin"]="KDE file manager used in Hyprland setup"
reasons["wpctl"]="WirePlumber controller for audio management"
reasons["brightnessctl"]="Backlight and LED brightness control"
reasons["playerctl"]="Media player control utility"
reasons["jq"]="Command-line JSON processor (used in scripts)"
reasons["matugen"]="Material Design 3 color scheme generator"

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
        "hyprlock"
        "hypridle"
        "hyprpm"
        "wofi"
        "waybar"
        "swww"
        "swaync"
        "dolphin"
        "wpctl"
        "brightnessctl"
        "playerctl"
        "jq"
        "matugen"
    )
fi

# Remove duplicates
unique_dependencies=($(printf "%s\n" "${dependencies[@]}" | sort -u))

missing_count=0

for tool in "${unique_dependencies[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
        reason="${reasons[$tool]:-Unknown purpose}"
        echo -e "    [${RED}✗${RESET}] ${YELLOW}$tool${RESET} - $reason"
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
