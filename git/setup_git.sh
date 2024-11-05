#!/bin/bash

# Check if git is installed
if [[ -z "$(which git)" ]]; then
    echo "git not found"
    exit 1
fi

self_path=$(realpath $0)
self_dir=$(dirname "$self_path")

git_templates_path="$self_dir/git_templates"

echo "Setting git templateDir to $git_templates_path"
git config --global init.templateDir "$git_templates_path"
