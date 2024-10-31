#!/bin/bash

set -euo pipefail

echo "Installing fzf from https://github.com/junegunn/fzf.git"
echo ""
echo "Deleting $HOME/.fzf"
rm -rf "$HOME/.fzf"
echo ""
echo "Cloning git repository"
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
echo ""
echo "Executing install script"
"$HOME/.fzf/install"
echo ""
echo "fzf installed!"
