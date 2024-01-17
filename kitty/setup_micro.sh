#!/bin/bash

set -xeuo pipefail

SCRIPT_DIR="$(dirname $BASH_SOURCE)"
SCRIPT_DIR="$(realpath $SCRIPT_DIR)"

KITTY_CONFIG_DIR="$(realpath $HOME)/.config/kitty"

THEME_LINK="https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/Dracula.conf"
THEME_PATH="$KITTY_CONFIG_DIR/theme.conf"


mkdir -p "$KITTY_CONFIG_DIR"

rm -f "$KITTY_CONFIG_DIR/kitty.conf"
rm -f "$KITTY_CONFIG_DIR/theme.conf"
ln -s "$SCRIPT_DIR/kitty.conf" "$KITTY_CONFIG_DIR/kitty.conf"


curl "$THEME_LINK" > "$THEME_PATH"
# Set selection_background and selection_foreground to none to invert
# color when highlighting
sed -i 's/^selection_background.*$/selection_background none/g' $THEME_PATH
sed -i 's/^selection_foreground.*$/selection_foreground none/g' $THEME_PATH
