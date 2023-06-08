#!/bin/bash

set -xeuo pipefail

PLUGINS=("aspell" "detectindent" "quoter")

SCRIPT_DIR="$(dirname $BASH_SOURCE)"
SCRIPT_DIR="$(realpath $SCRIPT_DIR)"

MICRO_CONFIG_DIR="$(realpath $HOME)/.config/micro"
mkdir -p "$MICRO_CONFIG_DIR"

rm -f "$MICRO_CONFIG_DIR/bindings.json"
rm -f "$MICRO_CONFIG_DIR/settings.json"
ln -s "$SCRIPT_DIR/bindings.json" "$MICRO_CONFIG_DIR/bindings.json"
ln -s "$SCRIPT_DIR/settings.json" "$MICRO_CONFIG_DIR/settings.json"

micro -plugin install ${PLUGINS[@]}
